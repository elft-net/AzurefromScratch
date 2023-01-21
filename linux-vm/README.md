# Terraform on Azure
Terraform calims to be provider agnostic. This obviously does not imply that manifests designed to build AWS environments can be used without changed to build on Azure. It just uses the same workflow:

```bash
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ az storage container create --account-name scratchvault --name tf-state

{
  "created": true
}
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ tree
.
├── init-script.sh
├── main.tf
├── network.tf
├── output.tf
├── security-group.tf
├── variables.tf
└── vm.tf

1 directory, 7 files
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ tf init                                                                         (main|…)  1:36PM
╷
│ Error: Unsupported Terraform Core version
│
│   on main.tf line 4, in terraform:
│    4:   required_version = "~> 0.12"
│
│ This configuration does not support Terraform version 1.3.7. To proceed, either choose another supported Terraform version or update this version
│ constraint. Version constraints are normally set for good reason, so updating the constraint may lead to other errors or unexpected behavior.
╵
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ tf --version
Terraform v1.3.7
on linux_amd64
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ 
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ tf init                                                                         (main|…)  2:00PM

Initializing the backend...

Successfully configured the backend "azurerm"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding latest version of hashicorp/external...
- Finding latest version of hashicorp/azurerm...
- Installing hashicorp/azurerm v3.40.0...
- Installed hashicorp/azurerm v3.40.0 (signed by HashiCorp)
- Installing hashicorp/external v2.2.3...
- Installed hashicorp/external v2.2.3 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ tf plan
╷
│ Error: Incorrect attribute value type
│
│   on network.tf line 30, in resource "azurerm_subnet" "pm-prod":
│   30:   address_prefixes     = cidrsubnet(azurerm_virtual_network.pm-prod.address_space, 8, 1)
│
│ Inappropriate value for attribute "address_prefixes": list of string required.
╵
/home/mos/Repo/src/elft-net/AzurefromScratch/linux-vm
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ vi network.tf
==>> address_prefixes     = tolist([cidrsubnet(element(azurerm_virtual_network.pm-labs.address_space, 1), 8, 1)])
}


[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ tf apply
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

vm_internalip = "10.0.1.5"
vm_name = "tf-demo-lab-vm"
vm_publicdns = "tf-demo-lab-direct.westeurope.cloudapp.azure.com"
vm_publicip = "20.105.179.71"
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$  
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ ssh 20.105.179.71                                                               (main|…) 10:15PM
The authenticity of host '20.105.179.71 (20.105.179.71)' can't be established.
ED25519 key fingerprint is SHA256:DZ3TwwPs/yFfALEc2qEOA7KgWqc13fPEV8Fl+3gDCxk.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '20.105.179.71' (ED25519) to the list of known hosts.
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1100-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Jan 20 21:17:25 UTC 2023

  System load:  0.31              Processes:           136
  Usage of /:   5.1% of 28.89GB   Users logged in:     0
  Memory usage: 5%                IP address for eth0: 10.0.1.5
  Swap usage:   0%

22 updates can be applied immediately.
19 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

mos@tf-azure-vm:~$ cat /etc/*release*
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.6 LTS"
NAME="Ubuntu"
VERSION="18.04.6 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.6 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
mos@tf-azure-vm:~$ exit
logout
Connection to 20.105.179.71 closed.
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ tf destroy
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_network_security_rule.pm-labs_any_out: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/networkSecurityGroups/tf-demo-lab-sg/securityRules/tf-demo-lab-any-out]
azurerm_network_security_rule.pm-labs_http_in: Destroying... [id=/subscriptions/<obscured>8/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/networkSecurityGroups/tf-demo-lab-sg/securityRules/tf-demo-lab-http-in]
azurerm_network_security_rule.pm-labs_ssh_in: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/networkSecurityGroups/tf-demo-lab-sg/securityRules/tf-demo-lab-ssh-in]
azurerm_network_security_rule.pm-labs_https_in: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/networkSecurityGroups/tf-demo-lab-sg/securityRules/tf-demo-lab-https-in]
azurerm_virtual_machine.pm-labs: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Compute/virtualMachines/tf-demo-lab-vm]
azurerm_network_security_rule.pm-labs_ssh_in: Still destroying... [id=/subscriptions/<obscured>...ab-sg/securityRules/tf-demo-lab-ssh-in, 10s elapsed]
azurerm_network_security_rule.pm-labs_http_in: Still destroying... [id=/subscriptions/<obscured>...b-sg/securityRules/tf-demo-lab-http-in, 10s elapsed]
azurerm_network_security_rule.pm-labs_any_out: Still destroying... [id=/subscriptions/<obscured>...b-sg/securityRules/tf-demo-lab-any-out, 10s elapsed]
azurerm_network_security_rule.pm-labs_https_in: Still destroying... [id=/subscriptions/<obscured>...-sg/securityRules/tf-demo-lab-https-in, 10s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 10s elapsed]
azurerm_network_security_rule.pm-labs_any_out: Destruction complete after 10s
azurerm_network_security_rule.pm-labs_https_in: Destruction complete after 10s
azurerm_network_security_rule.pm-labs_http_in: Still destroying... [id=/subscriptions/<obscured>...b-sg/securityRules/tf-demo-lab-http-in, 20s elapsed]
azurerm_network_security_rule.pm-labs_ssh_in: Still destroying... [id=/subscriptions/<obscured>...ab-sg/securityRules/tf-demo-lab-ssh-in, 20s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 20s elapsed]
azurerm_network_security_rule.pm-labs_ssh_in: Destruction complete after 21s
azurerm_network_security_rule.pm-labs_http_in: Destruction complete after 22s
azurerm_network_security_group.pm-labs: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/networkSecurityGroups/tf-demo-lab-sg]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 30s elapsed]
azurerm_network_security_group.pm-labs: Still destroying... [id=/subscriptions/<obscured>...k/networkSecurityGroups/tf-demo-lab-sg, 10s elapsed]
azurerm_network_security_group.pm-labs: Destruction complete after 11s
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 40s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 50s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 1m0s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 1m10s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 1m20s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 1m30s elapsed]
azurerm_virtual_machine.pm-labs: Still destroying... [id=/subscriptions/<obscured>...Compute/virtualMachines/tf-demo-lab-vm, 1m40s elapsed]
azurerm_virtual_machine.pm-labs: Destruction complete after 1m41s
azurerm_network_interface.pm-labs: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/networkInterfaces/tf-demo-lab-nic]
azurerm_network_interface.pm-labs: Destruction complete after 5s
azurerm_subnet.pm-labs: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/virtualNetworks/tf-demo-lab-net/subnets/tf-demo-lab-subnet]
azurerm_public_ip.pm-labs: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/publicIPAddresses/tf-demo-lab-publicip]
azurerm_public_ip.pm-labs: Still destroying... [id=/subscriptions/<obscured>...publicIPAddresses/tf-demo-lab-publicip, 10s elapsed]
azurerm_subnet.pm-labs: Still destroying... [id=/subscriptions/<obscured>...emo-lab-net/subnets/tf-demo-lab-subnet, 10s elapsed]
azurerm_subnet.pm-labs: Destruction complete after 10s
azurerm_virtual_network.pm-labs: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab/providers/Microsoft.Network/virtualNetworks/tf-demo-lab-net]
azurerm_public_ip.pm-labs: Still destroying... [id=/subscriptions/<obscured>...publicIPAddresses/tf-demo-lab-publicip, 20s elapsed]
azurerm_virtual_network.pm-labs: Still destroying... [id=/subscriptions/<obscured>...etwork/virtualNetworks/tf-demo-lab-net, 10s elapsed]
azurerm_public_ip.pm-labs: Destruction complete after 20s
azurerm_virtual_network.pm-labs: Destruction complete after 11s
azurerm_resource_group.pm-labs: Destroying... [id=/subscriptions/<obscured>/resourceGroups/pm-labs-tf-demo-lab]
azurerm_resource_group.pm-labs: Still destroying... [id=/subscriptions/<obscured>...9f8/resourceGroups/pm-labs-tf-demo-lab, 10s elapsed]
azurerm_resource_group.pm-labs: Destruction complete after 16s

Destroy complete! Resources: 11 destroyed.
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ az vm list                                      (main|…) 10:26PM
[]
[mos@core ~/…/elft-net/AzurefromScratch/linux-vm]$ 

