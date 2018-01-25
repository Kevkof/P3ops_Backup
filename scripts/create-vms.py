from jinja2 import Environment, FileSystemLoader
import yaml
import os
import time
from shutil import copyfile
import argparse

class Server(object):
    """Class representing a server configuration"""

    def __init__(self,
                 hostname, 
                 ip, 
                 network, 
                 netmask,
                 broadcast,
                 gateway,
                 mem,
                 vcpu):
        self.hostname = hostname
        self.ip = ip
        self.network = network
        self.netmask = netmask
        self.broadcast = broadcast
        self.gateway = gateway
        self.mem = mem
        self.vcpu = vcpu

    @staticmethod
    def load_from_dict(dic):
        """Create a new server object with data from a dictionary"""
        return Server(dic["hostname"],
                      dic["ip"],
                      dic["network"],
                      dic["netmask"],
                      dic["broadcast"],
                      dic["gateway"],
                      dic["mem"],
                      dic["vcpu"])

    @staticmethod
    def load_list_from_yaml(yaml_file):
        """Load a list of servers from a YAML file"""
        # Open the YAML file with read access
        with open(yaml_file, 'r') as yaml_data:
            data = yaml.safe_load(yaml_data)
        
        # Exception when loading failed
        if data is None:
            raise Exception("Coudn't load file '%s'." % yaml_file)
        
        # Create Server objects and return them in a list
        return list(map(lambda server: Server.load_from_dict(server), data))

def print_timestamped(text):
    """Print a string with a timestamp attached."""
    print "[%s] %s" % (time.strftime("%H:%M:%S", time.localtime()), text)

# Parse command line options

parser = argparse.ArgumentParser()
parser.add_argument("servers", help="The YAML file containing the server configurations.")
parser.add_argument("-t", "--tempdir", help="The temporary directory used to create the config files. Default: /tmp/cloud-init")
parser.add_argument("-i", "--imgdir", help="The directory where the images should be placed. Default: /var/lib/libvirt/images")
parser.add_argument("-b", "--baseimg", help="The base image that should be used. Default: %imgdir%/centos.qcow2")
parser.add_argument("-n", "--network", help="The network bridge that should be used. Default: virbr0")
args = parser.parse_args()

if os.path.exists(args.servers):
    servers_file = args.servers
else:
    raise Exception("File '%s' does not exist." % args.servers)

if args.tempdir:
    temp_dir = args.tempdir
else:
    temp_dir = "/tmp/cloud-init/"

if args.imgdir:
    img_dir = args.imgdir
else:
    img_dir = "/var/lib/libvirt/images/"

if args.baseimg:
    base_img = args.baseimg
else:
    base_img = os.path.join(img_dir, "centos.qcow2")

if args.network:
    network = args.network
else:
    network = "virbr0"

# Create the temporary directory if it doesn't exist
if not os.path.exists(temp_dir):
    print_timestamped("Directory '%s' does not exist; creating..." % temp_dir)
    os.makedirs(temp_dir)
else:
    print_timestamped("Directory '%s' already exists." % temp_dir)

# Initialise a Jinja2 environment that loads templates from the ./templates folder
env = Environment(
    loader=FileSystemLoader("./templates/")
)

# Load the config file templates
userdata_template = env.get_template("user-data")
metadata_template = env.get_template("meta-data")

# Load the list of servers from a YAML file
print_timestamped("Loading file '%s'" % servers_file)
servers = Server.load_list_from_yaml(servers_file)

# Loop through the servers
for server in servers:
    print_timestamped("Server: %s" % server.hostname)
    
    # Filename for log file
    log_file = "%s.log" % server.hostname

    print_timestamped("Destroying domain '%s' if it already exists" % server.hostname)
    os.system("virsh destroy %s >> %s 2>&1" % (server.hostname, log_file))
    os.system("virsh undefine %s >> %s 2>&1" % (server.hostname, log_file))

    # Create a subfolder for the server
    server_dir = os.path.join(temp_dir, server.hostname)
    if not os.path.exists(server_dir):
        print_timestamped("Directory '%s' does not exist; creating..." % server_dir)
        os.makedirs(server_dir)
    else:
        print_timestamped("Directory '%s' already exists." % server_dir)

    # Variables for the filenames of the config files
    userdata_file = os.path.join(server_dir, "user-data")
    metadata_file = os.path.join(server_dir, "meta-data")
    
    # Generate the config files
    with open(userdata_file, "wb") as fh:
        print_timestamped("Generating file: %s" % userdata_file)
        fh.write(userdata_template.render(hostname = server.hostname,
                                          default_gateway = server.gateway))
    with open(metadata_file, "wb") as fh:
        print_timestamped("Generating file: %s" % metadata_file)
        fh.write(metadata_template.render(hostname = server.hostname, 
                                          ip_address = server.ip, 
                                          network_address = server.network, 
                                          network_mask = server.netmask, 
                                          broadcast_address = server.broadcast,
                                          default_gateway = server.gateway))
    
    # Generate the cloud-init iso file
    iso_file = os.path.join(server_dir, "cidata.iso")
    print_timestamped("Generating file: %s" % iso_file)
    os.system("genisoimage -output %s -volid cidata -joliet -r %s %s &>> %s" % (iso_file, metadata_file, userdata_file, log_file))

    # Copy base image
    img_file = os.path.join(img_dir, "%s.qcow2" % server.hostname)
    print_timestamped("Copying base image to '%s'." % img_file)
    copyfile(base_img, img_file)
    print_timestamped("Copy completed")

    # Execute virt-install 
    print_timestamped("Executing virt-install")
    os.system("""virt-install --import --name %s --ram %s --vcpus %s --disk \\
                 %s,format=qcow2,bus=virtio --disk %s,device=cdrom --network \\
                 bridge=%s,model=virtio --os-type=linux --os-variant=rhel7 \\
                 --noautoconsole --cpu host --connect qemu:///system""" % (server.hostname, server.mem, server.vcpu, img_file, iso_file, network))
    print_timestamped("Server %s completed" % server.hostname)

print_timestamped("")
print_timestamped("All servers completed!")
