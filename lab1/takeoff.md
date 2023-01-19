# Getting hooked
- First entry within github which nicely integrates with Azure.
- Using git clone, add and commit to transfer files from the developer workstation
- Need to look into az-cli in order to take the next step
```
[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ az                                   (main|…)  3:26PM

     /\
    /  \    _____   _ _  ___ _
   / /\ \  |_  / | | | \'__/ _\
  / ____ \  / /| |_| | | |  __/
 /_/    \_\/___|\__,_|_|  \___|


Welcome to the cool new Azure CLI!

Use `az --version` to display the current version.
Here are the base commands:

    account             : Manage Azure subscription information.
    acr                 : Manage private registries with Azure Container Registries.
    ad                  : Manage Azure Active Directory Graph entities needed for Role Based Access
                         Control.
    advisor             : Manage Azure Advisor.
    afd                 : Manage Azure Front Door Standard/Premium. For classical Azure Front Door,
                         please refer https://docs.microsoft.com/en-us/cli/azure/network/front-
                         door?view=azure-cli-latest.
    aks                 : Manage Azure Kubernetes Services.
    ams                 : Manage Azure Media Services resources.
    apim                : Manage Azure API Management services.
    appconfig           : Manage App Configurations.
    appservice          : Manage App Service plans.
    aro                 : Manage Azure Red Hat OpenShift clusters.
    backup              : Manage Azure Backups.
    batch               : Manage Azure Batch.
    bicep               : Bicep CLI command group.
    billing             : Manage Azure Billing.
    bot                 : Manage Microsoft Azure Bot Service.
    cache               : Commands to manage CLI objects cached using the `--defer` argument.
    capacity            : Manage capacity resources.
    cdn                 : Manage Azure Content Delivery Networks (CDNs).
    cloud               : Manage registered Azure clouds.
    cognitiveservices   : Manage Azure Cognitive Services accounts.
    config              : Manage Azure CLI configuration.
    configure           : Manage Azure CLI configuration. This command is interactive.
    connection          : Commands to manage Service Connector local connections which allow local
                         environment to connect Azure Resource. If you want to manage connection for
                         compute service, please run 'az webapp/containerapp/spring connection'.
    consumption         : Manage consumption of Azure resources.
    container           : Manage Azure Container Instances.
    cosmosdb            : Manage Azure Cosmos DB database accounts.
    databoxedge         : Support data box edge device and management.
    deployment          : Manage Azure Resource Manager template deployment at subscription scope.
    deployment-scripts  : Manage deployment scripts at subscription or resource group scope.
    deploymentmanager   : Create and manage rollouts for your service.
    disk                : Manage Azure Managed Disks.
    disk-access         : Manage disk access resources.
    disk-encryption-set : Disk Encryption Set resource.
    dla                 : Manage Data Lake Analytics accounts, jobs, and catalogs.
    dls                 : Manage Data Lake Store accounts and filesystems.
    dms                 : Manage Azure Data Migration Service (DMS) instances.
    eventgrid           : Manage Azure Event Grid topics, domains, domain topics, system topics
                         partner topics, event subscriptions, system topic event subscriptions and
                         partner topic event subscriptions.
    eventhubs           : Manage Azure Event Hubs namespaces, eventhubs, consumergroups and geo
                         recovery configurations - Alias.
    extension           : Manage and update CLI extensions.
    feature             : Manage resource provider features.
    feedback            : Send feedback to the Azure CLI Team.
    find                : I'm an AI robot, my advice is based on our Azure documentation as well as
                         the usage patterns of Azure CLI and Azure ARM users. Using me improves
                         Azure products and documentation.
    functionapp         : Manage function apps. To install the Azure Functions Core tools see
                         https://github.com/Azure/azure-functions-core-tools.
    group               : Manage resource groups and template deployments.
    hdinsight           : Manage HDInsight resources.
    identity            : Managed Identities.
    image               : Manage custom virtual machine images.
    interactive         : Start interactive mode. Installs the Interactive extension if not
                         installed already.
    iot                 : Manage Internet of Things (IoT) assets.
    keyvault            : Manage KeyVault keys, secrets, and certificates.
    kusto               : Manage Azure Kusto resources.
    lab                 : Manage Azure DevTest Labs.
    lock                : Manage Azure locks.
    logicapp            : Manage logic apps.
    login               : Log in to Azure.
    logout              : Log out to remove access to Azure subscriptions.
    managed-cassandra   : Azure Managed Cassandra.
    managedapp          : Manage template solutions provided and maintained by Independent Software
                         Vendors (ISVs).
    managedservices     : Manage the registration assignments and definitions in Azure.
    maps                : Manage Azure Maps.
    mariadb             : Manage Azure Database for MariaDB servers.
    monitor             : Manage the Azure Monitor Service.
    mysql               : Manage Azure Database for MySQL servers.
    netappfiles         : Manage Azure NetApp Files (ANF) Resources.
    network             : Manage Azure Network resources.
    policy              : Manage resource policies.
    postgres            : Manage Azure Database for PostgreSQL servers.
    ppg                 : Manage Proximity Placement Groups.
    private-link        : Private-link association CLI command group.
    provider            : Manage resource providers.
    redis               : Manage dedicated Redis caches for your Azure applications.
    relay               : Manage Azure Relay Service namespaces, WCF relays, hybrid connections, and
                         rules.
    resource            : Manage Azure resources.
    resourcemanagement  : Resourcemanagement CLI command group.
    rest                : Invoke a custom request.
    restore-point       : Manage restore point with res.
    role                : Manage user roles for access control with Azure Active Directory and
                         service principals.
    search              : Manage Azure Search services, admin keys and query keys.
    security            : Manage your security posture with Microsoft Defender for Cloud.
    servicebus          : Manage Azure Service Bus namespaces, queues, topics, subscriptions, rules
                         and geo-disaster recovery configuration alias.
    sf                  : Manage and administer Azure Service Fabric clusters.
    sig                 : Manage shared image gallery.
    signalr             : Manage Azure SignalR Service.
    snapshot            : Manage point-in-time copies of managed disks, native blobs, or other
                         snapshots.
    sql                 : Manage Azure SQL Databases and Data Warehouses.
    sshkey              : Manage ssh public key with vm.
    staticwebapp        : Manage static apps.
    storage             : Manage Azure Cloud Storage resources.
    survey              : Take Azure CLI survey.
    synapse             : Manage and operate Synapse Workspace, Spark Pool, SQL Pool.
    tag                 : Tag Management on a resource.
    term                : Manage marketplace agreement with marketplaceordering.
    ts                  : Manage template specs at subscription or resource group scope.
    upgrade             : Upgrade Azure CLI and extensions.
    version             : Show the versions of Azure CLI modules and extensions in JSON format by
                         default or format configured by --output.
    vm                  : Manage Linux or Windows virtual machines.
    vmss                : Manage groupings of virtual machines in an Azure Virtual Machine Scale Set
                         (VMSS).
    webapp              : Manage web apps.
[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ az login
A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
15:34:22 INFO: Opening in existing instance
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "<obfuscated>",
    "id": "<obfuscated>",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantId": "<obfuscated>",
    "user": {
      "name": "<obfuscated>",
      "type": "user"
    }
  }
]
[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ az vm list
[]
[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ az storage account list
[]
[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ az keyvault list
[]
[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ az interactive                                  (main|…)  3:48PM

This command is in preview and under development. Reference and support levels: https://aka.ms/CLI_refstatus
Installing the Interactive extension...
The installed extension 'interactive' is in preview.

Do you agree to sending telemetry (yes/no)? Default answer is yes: no

az>> az group create --name AzurefromScratch --location westeurope
az>> az vm create --resource-group AzurefromScratch --name pm-azurevm-1 --image UbuntuLTS --output json --verbose

Starting Build 2023 event, "az vm/vmss create" command will deploy Trusted Launch VM by default. To know more about Trusted Launch, please visit https://docs.microsoft.com/en-us/azure/virtual-machines/trusted-launch
It is recommended to use parameter "--public-ip-sku Standard" to create new VM with Standard public IP. Please note that the default public IP used for VM creation will be changed from Basic to Standard in the future.
{
  "fqdns": "",
  "id": "/subscriptions/<obfuscated>/resourceGroups/AzurefromScratch/providers/Microsoft.Compute/virtualMachines/pm-azurevm-1",
  "location": "westeurope",
  "macAddress": "00-0D-3A-BB-70-33",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "20.71.224.162",
  "resourceGroup": "AzurefromScratch",
  "zones": ""
}
az>> quit

[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ ssh 20.71.224.162                               (main|…)  4:16PM
The authenticity of host '20.71.224.162 (20.71.224.162)' can't be established.
ED25519 key fingerprint is SHA256:LlTUgvJXiCu/E9MShYiQgVH+eDEETrJ4pbqM4+58aiA.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '20.71.224.162' (ED25519) to the list of known hosts.
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1100-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Jan 18 15:16:56 UTC 2023

  System load:  0.02              Processes:           110
  Usage of /:   4.5% of 28.89GB   Users logged in:     0
  Memory usage: 5%                IP address for eth0: 10.0.0.4
  Swap usage:   0%

0 updates can be applied immediately.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

mos@pm-azurevm-1:~$ sudo lshw
pm-azurevm-1
    description: Desktop Computer
    product: Virtual Machine
    vendor: Microsoft Corporation
    version: 7.0
    serial: 0000-0002-8904-7619-7825-1683-26
    width: 64 bits
    capabilities: smbios-2.3 dmi-2.3 vsyscall32
    configuration: boot=normal chassis=desktop uuid=C9081D28-179B-C643-9F74-D4D11BA5A664
  *-core
       description: Motherboard
       product: Virtual Machine
       vendor: Microsoft Corporation
       physical id: 0
       version: 7.0
       serial: 0000-0011-4900-4254-3906-0721-64
     *-firmware
          description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 090008
          date: 12/07/2018
          size: 64KiB
          capacity: 192KiB
          capabilities: isa pci pnp upgrade shadowing escd cdboot bootselect socketedrom edd int13floppy360 int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video agp ls120boot zipboot biosbootspecification
     *-cpu:0
          description: CPU
          product: Intel(R) Xeon(R) Platinum 8370C CPU @ 2.80GHz
          vendor: Intel Corp.
          physical id: 5
          bus info: cpu@0
          version: Intel(R) Xeon(R) Platinum 8370C CPU @ 2.80GHz
          serial: None
          slot: None
          size: 2800MHz
          capacity: 3500MHz
          width: 64 bits
          clock: 100MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp x86-64 constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid rtm avx512f avx512dq rdseed adx smap clflushopt avx512cd avx512bw avx512vl xsaveopt xsavec xsaves md_clear
     *-cpu:1 DISABLED
          description: CPU [empty]
          product: (None)
          vendor: None
          physical id: 6
          version: None
          serial: None
          slot: None
     *-cpu:2 DISABLED
          description: CPU [empty]
          product: (None)
          vendor: None
          physical id: 7
          version: None
          serial: None
          slot: None
          slot: None
	  .
	  .
	  .
     *-cpu:60 DISABLED
          description: CPU [empty]
          product: (None)
          vendor: None
          physical id: 41
          version: None
          serial: None
          slot: None
     *-cpu:61 DISABLED
          description: CPU [empty]
          product: (None)
          vendor: None
          physical id: 42
          version: None
          serial: None
          slot: None
     *-cpu:62 DISABLED
          description: CPU [empty]
          product: (None)
          vendor: None
          physical id: 43
          version: None
          serial: None
          slot: None
     *-cpu:63 DISABLED
          description: CPU [empty]
          product: (None)
          vendor: None
          physical id: 44
          version: None
          serial: None
          slot: None
     *-memory
          description: System Memory
          physical id: 51
          size: 3584MiB
        *-bank:0
             product: None
             vendor: Microsoft
             physical id: 0
             serial: None
             slot: M0
             size: 1GiB
        *-bank:1
             product: None
             vendor: Microsoft
             physical id: 1
             serial: None
             slot: M1
             size: 2560MiB
        *-bank:2
             description: [empty]
             product: None
             vendor: Microsoft
             physical id: 2
             serial: None
             slot: M2
        *-bank:3
             description: [empty]
             product: None
             vendor: Microsoft
             physical id: 3
             serial: None
             slot: M3
	     .
	     .
	     .
        *-bank:123
             description: [empty]
             product: None
             vendor: Microsoft
             physical id: 7b
             serial: None
             slot: M123
        *-bank:124
             description: [empty]
             product: None
             vendor: Microsoft
             physical id: 7c
             serial: None
             slot: M124
     *-pci
          description: Host bridge
          product: 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled)
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 03
          width: 32 bits
          clock: 33MHz
        *-isa
             description: ISA bridge
             product: 82371AB/EB/MB PIIX4 ISA
             vendor: Intel Corporation
             physical id: 7
             bus info: pci@0000:00:07.0
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master
             configuration: latency=0
        *-ide
             description: IDE interface
             product: 82371AB/EB/MB PIIX4 IDE
             vendor: Intel Corporation
             physical id: 7.1
             bus info: pci@0000:00:07.1
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: ide isa_compatibility_mode-only_controller__supports_bus_mastering bus_master
             configuration: driver=ata_piix latency=0
             resources: irq:0 ioport:1f0(size=8) ioport:3f6 ioport:170(size=8) ioport:376 ioport:ffa0(size=16)
        *-bridge UNCLAIMED
             description: Bridge
             product: 82371AB/EB/MB PIIX4 ACPI
             vendor: Intel Corporation
             physical id: 7.3
             bus info: pci@0000:00:07.3
             version: 02
             width: 32 bits
             clock: 33MHz
             capabilities: bridge
             configuration: latency=0
        *-display
             description: VGA compatible controller
             product: Hyper-V virtual VGA
             vendor: Microsoft Corporation
             physical id: 8
             bus info: pci@0000:00:08.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: vga_controller bus_master rom
             configuration: driver=hyperv_fb latency=0
             resources: irq:11 memory:f8000000-fbffffff memory:c0000-dffff
     *-scsi:0
          physical id: 1
          logical name: scsi1
        *-disk
             description: SCSI Disk
             product: Virtual Disk
             vendor: Msft
             physical id: 0.1.0
             bus info: scsi@1:0.1.0
             logical name: /dev/sda
             version: 1.0
             size: 7GiB (7516MB)
             capabilities: partitioned partitioned:dos
             configuration: ansiversion=5 logicalsectorsize=512 sectorsize=4096 signature=281d08c9
           *-volume
                description: EXT4 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@1:0.1.0,1
                logical name: /dev/sda1
                logical name: /mnt
                version: 1.0
                serial: bb969279-1647-4a4d-9115-a737367b5b1d
                size: 7166MiB
                capacity: 7166MiB
                capabilities: primary journaled extended_attributes large_files huge_files dir_nlink recover 64bit extents ext4 ext2 initialized
                configuration: created=2023-01-18 15:13:28 filesystem=ext4 lastmountpoint=/mnt modified=2023-01-18 15:13:28 mount.fstype=ext4 mount.options=rw,relatime mounted=2023-01-18 15:13:28 state=mounted
     *-scsi:1
          physical id: 2
          logical name: scsi0
        *-disk
             description: SCSI Disk
             product: Virtual Disk
             vendor: Msft
             physical id: 0.0.0
             bus info: scsi@0:0.0.0
             logical name: /dev/sdb
             version: 1.0
             size: 30GiB (32GB)
             capabilities: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=5 guid=f043a51f-6ba7-40b6-a097-c28de973de9b logicalsectorsize=512 sectorsize=4096
           *-volume:0
                description: EXT4 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@0:0.0.0,1
                logical name: /dev/sdb1
                logical name: /
                version: 1.0
                serial: b2fc75a0-1b27-4b2e-bfbd-84236b0f49ee
                size: 2140MiB
                capacity: 29GiB
                capabilities: journaled extended_attributes large_files huge_files dir_nlink recover 64bit extents ext4 ext2 initialized
                configuration: created=2023-01-10 15:51:55 filesystem=ext4 label=cloudimg-rootfs lastmountpoint=/tmp/tmp.cUnCSNqk3g modified=2023-01-18 15:13:07 mount.fstype=ext4 mount.options=rw,relatime,discard mounted=2023-01-18 15:13:08 state=mounted
           *-volume:1
                description: BIOS Boot partition
                vendor: EFI
                physical id: e
                bus info: scsi@0:0.0.0,14
                logical name: /dev/sdb14
                serial: edf42a4d-7fe7-41de-ad42-2c404928f10c
                capacity: 4095KiB
                capabilities: nofs
           *-volume:2
                description: Windows FAT volume
                vendor: mkfs.fat
                physical id: f
                bus info: scsi@0:0.0.0,15
                logical name: /dev/sdb15
                logical name: /boot/efi
                version: FAT32
                serial: 9af4-112d
                size: 105MiB
                capacity: 105MiB
                capabilities: boot fat initialized
                configuration: FATs=2 filesystem=fat label=UEFI mount.fstype=vfat mount.options=rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro state=mounted
     *-scsi:2
          physical id: 3
          logical name: scsi5
          capabilities: emulated
        *-cdrom
             description: DVD reader
             product: Virtual CD/ROM
             vendor: Msft
             physical id: 0.0.0
             bus info: scsi@5:0.0.0
             logical name: /dev/cdrom
             logical name: /dev/dvd
             logical name: /dev/sr0
             version: 1.0
             capabilities: removable audio dvd
             configuration: ansiversion=5 status=nodisc
  *-network
       description: Ethernet interface
       physical id: 1
       logical name: eth0
       serial: 00:0d:3a:bb:70:33
       capabilities: ethernet physical
       configuration: autonegotiation=off broadcast=yes driver=hv_netvsc duplex=full firmware=N/A ip=10.0.0.4 link=yes multicast=yes

mos@pm-azurevm-1:~$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtual VGA

mos@pm-azurevm-1:~$ exit
logout
Connection to 20.71.224.162 closed.

[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ 
```

Astonishing transparcy from my Linux workstation . . . . 
Trying to remove the Resource account to see if it cleans up after me.

```
[mos@core ~/…/elft-net/AzurefromScratch/lab1]$ az interactive
az>> group delete --name AzurefromScratch
Are you sure you want to perform this operation? (y/n): y
az>> group list
[
  {
    "id": "/subscriptions/6739838f-3596-4dc2-a62c-91b294ccd9f8/resourceGroups/NetworkWatcherRG",
    "location": "westeurope",
    "managedBy": null,
    "name": "NetworkWatcherRG",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  }
]
az>> group delete --name NetworkWatcherRG
Are you sure you want to perform this operation? (y/n): y
az>> az vm list
[]
az>>
```
Who would have thought . . . . . 
