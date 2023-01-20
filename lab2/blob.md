# Azure blob storage

Goals:
- Basics: Look into how storage can be shared. Upload, Download, Mounted between workstation and Azure
- Specifics:
 	- how is Authorisation taken care off
	- has version control been implemented
	- can the Blob-content be shared by distributing a signed url
	- can the blob be locked (made inmutable)
	-  . . . . 
	   
Let's plan:
```bash
az login
az group create --name AzurefromScratch --location westeurope
az storage account create --name scratchvault --resource-group AzurefromScratch --sku Standard_ZRS --encryption-services blob
az storage container create --account-name scratchvault --name pm-tank-01
az storage blob upload --account-name scratchStore --container-name pm-tank-01 --name blob.md --file blob.md
az storage blob list --account-name scratchvault --container-name pm-tank-01
```

This should:
Establish a session to Azure, create a resource group, storage account, storage container (bucket) and move this document into it. As far as the --sku parameter goes, the reply od OpenAI was sub-optimal:
```bash
[mos@core ~/Repo/src/elft-net]$ z explain and list the possible values for --sku for a Storage Blob within Azure
Response:

--sku (Storage SKU) is used to select the type of tier for a storage blob. The available options for --sku are: Standard (default), Premium and Archive.
Standard: This Sku allows for hot and cool access tiers, with a possibility of early deletion fees.
Premium: This Sku allows for hot access tier, which is optimized for high performance.
Archive:This Sku allows for Archive access tier, which is optimized for low cost storage.
```
Needed to point my browser to [Microsoft Learn] (https://learn.microsoft.com/en-us/rest/api/storagerp/srp_sku_types) to get the definite answer.
Then there were issues with the value for --account-name. Trying scratchstore, scrapstore and snapstore barked at me that those names were already taken. It seems that the name needs to be globally unique. It hushed while getting tagged with: scratchvault.  

## The final verdict
```bash
[mos@core ~/…/elft-net/AzurefromScratch/lab2]$ az storage blob list --account-name scratchvault --container-name pm-tank-01                        (main|✚ 1…) 12:39PM

There are no credentials provided in your command and environment, we will query for account key for your storage account.
It is recommended to provide --connection-string, --account-key or --sas-token in your command as credentials.

You also can add `--auth-mode login` in your command to use Azure Active Directory (Azure AD) for authorization if your login account is assigned required RBAC roles.
For more information about RBAC roles in storage, visit https://docs.microsoft.com/azure/storage/common/storage-auth-aad-rbac-cli.

In addition, setting the corresponding environment variables can avoid inputting credentials in your command. Please use --help to get more information about environment variable usage.
[
  {
    "container": "pm-tank-01",
    "content": "",
    "deleted": null,
    "encryptedMetadata": null,
    "encryptionKeySha256": null,
    "encryptionScope": null,
    "hasLegalHold": null,
    "hasVersionsOnly": null,
    "immutabilityPolicy": {
      "expiryTime": null,
      "policyMode": null
    },
    "isAppendBlobSealed": null,
    "isCurrentVersion": null,
    "lastAccessedOn": null,
    "metadata": {},
    "name": "blob.md",
    "objectReplicationDestinationPolicy": null,
    "objectReplicationSourceProperties": [],
    "properties": {
      "appendBlobCommittedBlockCount": null,
      "blobTier": "Hot",
      "blobTierChangeTime": null,
      "blobTierInferred": true,
      "blobType": "BlockBlob",
      "contentLength": 1955,
      "contentRange": null,
      "contentSettings": {
        "cacheControl": null,
        "contentDisposition": null,
        "contentEncoding": null,
        "contentLanguage": null,
        "contentMd5": "9iIUUYqRbeViUjHg9srCHQ==",
        "contentType": "text/markdown"
      },
      "copy": {
        "completionTime": null,
        "destinationSnapshot": null,
        "id": null,
        "incrementalCopy": null,
        "progress": null,
        "source": null,
        "status": null,
        "statusDescription": null
      },
      "creationTime": "2023-01-19T11:33:04+00:00",
      "deletedTime": null,
      "etag": "0x8DAFA10EDDBFC5D",
      "lastModified": "2023-01-19T11:33:04+00:00",
      "lease": {
        "duration": null,
        "state": "available",
        "status": "unlocked"
      },
      "pageBlobSequenceNumber": null,
      "pageRanges": null,
      "rehydrationStatus": null,
      "remainingRetentionDays": null,
      "serverEncrypted": true
    },
    "rehydratePriority": null,
    "requestServerEncrypted": null,
    "snapshot": null,
    "tagCount": null,
    "tags": null,
    "versionId": null
  }
]

```
Although this works up until here I prefer the (AWS) bucket way of working where you can just get going with: aws s3 mb <bucket-name>, aws s3 ls, aws s3 cp <local> <s3:> or aws s3 <s3:> <local>. So let's try improve the transparancy within Azure by mounting the Storage Blob on the workstation. The procedure to follow is documented here: https://learn.microsoft.com/en-us/azure/storage/blobs/storage-how-to-mount-container-linux

Lets ask openAI before we start:
```bash
[mos@core ~/Repo/src/elft-net]$ plz generate a bash script that mounts an Azure Blobstore on a fedora workstation using blobfuse2                    (:|✔)  2:05PM
✔ Got some code!
───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# Install blobfuse
sudo yum install blobfuse

# Set environment variables
export AZURE_STORAGE_ACCOUNT=<storage_account_name>
export AZURE_STORAGE_ACCESS_KEY=<storage_account_key>

# Create a mount point
mkdir <mount_point>

# Mount the blobstore
blobfuse <mount_point> --tmp-path=/mnt/blobfusetmp --config-file=/etc/blobfuse/fuse_connection.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120
───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
>> Run the generated program? [Y/n] n
[mos@core ~/Repo/src/elft-net]$ 
```
Ahhh well, might work for Ubuntu . . . . . Think it's related to v1 though and not for fedora.
Guess we need to refactor.

```
sudo dnf install blobfuse2
sudo mkdir /mnt/ramdisk
sudo mount -t tmpfs -o size=4g tmpfs /mnt/ramdisk
sudo mkdir /mnt/ramdisk/blobfusetmp
sudo chown mos /mnt/ramdisk/blobfusetmp
mkdir -p ~/Cloud/blobstore

blobfuse2 ~/Cloud/blobstore --tmp-path=/mnt/ramdisk/blobfusetmp --config-file=~/.config/blobfuse/config.yaml -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120

==> Error: failed to initialize new pipeline [failed to get credential]

az storage account keys list --resource-group AzurefromScratch --account-name scratchvault

```
Add one of the two Account keys (suggest key1) to the config.yaml file. Changed the mode to 600 for config.yaml just to protect the innocent.
Still doesn't work though . . . key doesn't get recognized, same error. Had to sleep on it . . . . 

```
[mos@core ~/Repo/src]$ blobfuse2 ~/Cloud/blobstore --tmp-path=/mnt/ramdisk/blobfusetmp --config-file=~/.config/blobfuse/config.yaml   (:|✔)  8:00AM
Error: failed to initialize new pipeline [failed to authenticate credentials for azstorage]
[mos@core ~/Repo/src]$ journalctl
Jan 20 08:00:08 core blobfuse2[335637]: LOG_CRIT [mount.go (364)]: Starting Blobfuse2 Mount : 2.0.1 on [Fedora Linux 37 (Thirty Seven)]
Jan 20 08:00:08 core blobfuse2[335637]: LOG_CRIT [mount.go (365)]: Logging level set to : LOG_DEBUG
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [libfuse.go (220)]: Libfuse::Configure : libfuse
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [libfuse.go (260)]: Libfuse::Configure : read-only false, allow-other true, default-perm 511, entry-timeout 120, attr-time 120, negative-timeout 240, ignore-open-flags: false, nonempty false
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [stream.go (100)]: Stream::Configure : stream
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [read_write.go (58)]: ReadWriteCache::Configure : Streamonly set to true
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [stream.go (132)]: Stream::Configure : Buffer size 0, Block size 8, Handle limit 0
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [attr_cache.go (121)]: AttrCache::Configure : attr_cache
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [attr_cache.go (145)]: AttrCache::Configure : cache-timeout 7200, symlink false, cache-on-list true
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [azstorage.go (83)]: AzStorage::Configure : azstorage
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [config.go (270)]: ParseAndValidateConfig : Parsing config
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [config.go (372)]: ParseAndValidateConfig : using the following proxy address from the config file:
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [config.go (376)]: ParseAndValidateConfig : sdk logging from the config file: false
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [config.go (479)]: ParseAndReadDynamicConfig : Reparsing config
Jan 20 08:00:08 core blobfuse2[335637]: LOG_DEBUG [config.go (383)]: ParseAndValidateConfig : Getting auth type
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [config.go (467)]: ParseAndValidateConfig : Account: scratchvault, Container: pm-store-01, AccountType: BLOCK, Auth: KEY, Prefix: , Endpoint: https://scratchvault.blob.core.windows.net/, ListBlock: 0, MD5 : false false, Vi>
Jan 20 08:00:08 core blobfuse2[335637]: LOG_INFO [config.go (471)]: ParseAndValidateConfig : Retry Config: Retry count 5, Max Timeout 900, BackOff Time 4, Max Delay 60
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [block_blob.go (173)]: BlockBlob::SetupPipeline : Setting up
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [block_blob.go (135)]: BlockBlob::getCredential : Getting credential
Jan 20 08:00:08 core blobfuse2[335637]: LOG_DEBUG [azauth.go (79)]: azAuth::getAzAuth : Account: scratchvault, AccountType: BLOCK, Protocol: https, Endpoint: https://scratchvault.blob.core.windows.net/
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [block_blob.go (260)]: BlockBlob::SetPrefixPath : path
Jan 20 08:00:08 core blobfuse2[335637]: LOG_TRACE [block_blob.go (209)]: BlockBlob::TestPipeline : Validating
Jan 20 08:00:09 core blobfuse2[335637]: LOG_ERR [block_blob.go (227)]: BlockBlob::TestPipeline : Failed to validate account with given auth %!s(func() string=0xc05f60)
Jan 20 08:00:09 core blobfuse2[335637]: LOG_ERR [azstorage.go (154)]: AzStorage::configureAndTest : Failed to validate credentials [-> github.com/Azure/azure-storage-blob-go/azblob.newStorageError, /home/cloudtest/go/pkg/mod/github.com/!azure/azure-storage-blob-go@v0.13.>
                                        ===== RESPONSE ERROR (ServiceCode=ContainerNotFound) =====
                                        Description=The specified container does not exist.
                                        RequestId:530ac1c4-d01e-00e8-7d9c-2cd910000000
                                        Time:2023-01-20T07:00:09.0548904Z, Details:
                                           Code: ContainerNotFound
                                           GET https://scratchvault.blob.core.windows.net/pm-store-01?comp=list&delimiter=%2F&maxresults=2&restype=container&timeout=901
                                           Authorization: REDACTED
                                           User-Agent: [Azure-Storage-Fuse/2.0.1 (Fedora Linux 37 (Thirty Seven)) Azure-Storage/0.14 (go1.16.2; linux)]
                                           X-Ms-Client-Request-Id: [66ca1120-fd31-48dc-59c2-44c3cb175cf2]
                                           X-Ms-Date: [Fri, 20 Jan 2023 07:00:08 GMT]
                                           X-Ms-Version: [2020-08-04]
                                           --------------------------------------------------------------------------------
                                           RESPONSE Status: 404 The specified container does not exist.
                                           Content-Length: [225]
                                           Content-Type: [application/xml]
                                           Date: [Fri, 20 Jan 2023 07:00:08 GMT]
                                           Server: [Windows-Azure-Blob/1.0 Microsoft-HTTPAPI/2.0]
                                           X-Ms-Client-Request-Id: [66ca1120-fd31-48dc-59c2-44c3cb175cf2]
                                           X-Ms-Error-Code: [ContainerNotFound]
                                           X-Ms-Request-Id: [530ac1c4-d01e-00e8-7d9c-2cd910000000]
                                           X-Ms-Version: [2020-08-04]


                                        ]
Jan 20 08:00:09 core blobfuse2[335637]: LOG_ERR [azstorage.go (100)]: AzStorage::Configure : Failed to validate storage account [failed to authenticate credentials for azstorage]
Jan 20 08:00:09 core blobfuse2[335637]: LOG_ERR [pipeline.go (69)]: Pipeline: error creating pipeline component azstorage [failed to authenticate credentials for azstorage]
Jan 20 08:00:09 core blobfuse2[335637]: LOG_ERR [mount.go (368)]: mount : failed to initialize new pipeline [failed to authenticate credentials for azstorage]
Jan 20 08:01:01 core CROND[338612]: (root) CMD (run-parts /etc/cron.hourly)
Jan 20 08:01:01 core run-parts[338615]: (/etc/cron.hourly) starting 0anacron
Jan 20 08:01:01 core run-parts[338621]: (/etc/cron.hourly) finished 0anacron
Jan 20 08:01:01 core CROND[338611]: (root) CMDEND (run-parts /etc/cron.hourly)
lines 1100357-1100420/1100420 (END)
```
Now the then use the mounted Cloud storage as if (Note the blob.md we added before):
```
[mos@core ~/Cloud/blobstore]$ cp ~/.local/doc/devOps/AWS*.pdf .
[mos@core ~/Cloud/blobstore]$ ls -lah
total 0
-rwxrwxrwx. 1 mos mos 787K Jan 20 09:26 AWS_Auditing_Security_Checklist.pdf
-rwxrwxrwx. 1 mos mos 644K Jan 20 09:26 AWS_Backup_Recovery.pdf
-rwxrwxrwx. 1 mos mos 858K Jan 20 09:26 AWS_Building_Fault_Tolerant_Applications.pdf
-rwxrwxrwx. 1 mos mos 169K Jan 20 09:27 AWS_certified_sysops_associate_blueprint.pdf
-rwxrwxrwx. 1 mos mos 281K Jan 20 09:27 AWS_Cloud_Architectures.pdf
-rwxrwxrwx. 1 mos mos 994K Jan 20 09:27 AWS_Disaster_Recovery.pdf
-rwxrwxrwx. 1 mos mos 2.0K Jan 19 12:33 blob.md
[mos@core ~/Cloud/blobstore]$ du -sh ..
0       ..
[mos@core ~/Cloud/blobstore]$ du -sh .
0       .
[mos@core ~/Cloud/blobstore]$ du -sh ~/Cloud
0       /home/mos/Cloud
[mos@core ~/Cloud/blobstore]$ rm *.pdf                                                                                                   (:|✔)  9:52AM
[mos@core ~/Cloud/blobstore]$ ls                                                                                                         (:|✔)  9:52AM
blob.md
[mos@core ~/Cloud/blobstore]$ mount | rg Cloud                                                                                           (:|✔)  9:52AM
blobfuse2 on /home/mos/Cloud/blobstore type fuse (rw,nosuid,nodev,relatime,user_id=111,group_id=111,allow_other)
[mos@core ~/Cloud/blobstore]$ 
```
The config file used for mounting (focussed on getting things working, might need tuning):
```yaml
$schema: https://azuremlschemas.azureedge.net/latest/azureBlob.schema.json
# Refer ./setup/baseConfig.yaml for full set of config parameters

allow-other: true

logging:
  type: syslog
  level: log_debug

components:
  - libfuse
  - stream
  - attr_cache
  - azstorage

libfuse:
  attribute-expiration-sec: 120
  entry-expiration-sec: 120
  negative-entry-expiration-sec: 240

stream:
  block-size-mb: 8
  blocks-per-file: 3
  cache-size-mb: 1024

attr_cache:
  timeout-sec: 7200

azstorage:
  type: block
  account-name: scratchvault
  account-key: <obfuscated>
  endpoint: https://scratchvault.blob.core.windows.net
  mode: key
  container: pm-tank-01
```

## Notes:
- Reading the log finally helped out => The key is not the issue here, it's the name of the container (should be pm-tank-01 iso pm-store-01)
- Caused too much time, caused by the fuzzy message at the frontend: Invalid key iso Container doesn't exist.
- V2 is relatively new documentation documentation, there is little documentation and searches get bloated with V1 configs which are way off (this is also why OpenAI didn't help us much).
- Besides user_allow_other needs to be set in /etc/fuse.conf but that issue is way easier to troubleshoot
- The endresult is quite transparent (du doesn't work properly), feels a bit sluggish but I'm very happy we got things humming . . . in the end








	   


