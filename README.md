# Project1
Azure Setup
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![stuff](https://github.com/cmhem/Project1/blob/main/Diagrams/withelk.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the .yml file may be used to install only certain pieces of it, such as Filebeat.
'''yaml
 ---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:
    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

      # Use apt module
    - name: Install pip3
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

      # Use pip module
    - name: Install Docker python module
      pip:
        name: docker
        state: present

      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes

      # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044

      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes
'''

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly protected, in addition to restricting shutdowns to the network.
The load balancers will help to protect from a denial of service attack. The load balancer will direct traffic to another vvirtual machine if one becomes flooded or compromised. The jump box allows for configurrations to the web vitrual machines. It also protects the machines from being comprromised since they only allow the jump box to access them through SSH.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system servers.
Filebeat will watch for any changes in locations and monitor the logs.
Metricbeat will watch the servers by collecting statistics and relaying them.

The configuration details of each machine may be found below.

| Name     | Function   | IP Address | Operating System |
|----------|------------|------------|------------------|
| Jump Box | Gateway    | 10.0.0.4   | Linux            |
| Web 1    | Web Server | 10.0.0.5   | Ubuntu           |
| Web 2    | Web Server | 10.0.0.6   | Ubuntu           |
| Elk VM   | ELK Server | 10.1.0.4   | Ubuntu           |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
73.222.75.120

Machines within the network can only be accessed by the Jump Box virtual machine.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | No                  | 10.0.0.1 10.0.0.2    |
| Web 1    | No                  | 10.0.0.4             |
| Web 2    | No                  | 10.0.0.4             |
| Elk VM   | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it makes updating the machines simple. Additionally, it is easy to update every machine within the group at once.

The playbook implements the following tasks:
- Install docker
- Install pip3
- Install Docker python module
- Download and Launch a docker ELK container
- Enable service docker on boot

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6

We have installed the following Beats on these machines:
- ELK machine

These Beats allow us to collect the following information from each machine:
- Allows us to collect information on the amount of traffic on a webpage. This would help to detect an DoS attack.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook file to the ansible.
- Update the ansible hosts file to include <IP address> ansible_python_interpreter=/usr/bin/python3
- Segment the IP adresses into sections to make it easier to manage different groups of machines better
- Run the playbook, and navigate to the http://[your.VM.IP]:5601/app/kibana to check that the installation worked as expected.
