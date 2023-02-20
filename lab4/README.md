# Serverless and Containerization

Aksing google this time around:
```bash
falls[mos@core ~/…/elft-net/AzurefromScratch/lab4]$ q what is that Azure alternative for Lambda
╭───────────────────────────────────────────────────────────────────────────────────────────────╮
│ The serverless functions are customizable, and that is what makes them so useful for building │
│  diverse applications. Azure Function, being the best AWS Lambda equivalent, has enabled open │
│   binding extensions within it. It is for allowing the community to create new bindings and   │
│                             implement them into the Function apps.                            │
╰───────────────────────────────────────────────────────────────────────────────────────────────╯
selector chosen: snippets1
[mos@core ~/…/elft-net/AzurefromScratch/lab4]$ q what is that Azure alternative for ECS or EKS
╭──────────────────────────────────────────────────────────────────────────────────────────╮
│ While Azure\'s answer to EKS is AKS, its analog to AWS Fargate and ECS is Azure Container │
│    Instances (ACI), which is another clustering solution for containerized workloads.    │
╰──────────────────────────────────────────────────────────────────────────────────────────╯
selector chosen: snippets1
[mos@core ~/…/elft-net/AzurefromScratch/lab4]$ q which languages are supported by Azure Functions
╭─────────────╮
│   Python.   │
├─────────────┤
│    .NET.    │
├─────────────┤
│ JavaScript. │
├─────────────┤
│    Java.    │
├─────────────┤
│     Go.     │
╰─────────────╯
selector chosen: snippets2
[mos@core ~/…/elft-net/AzurefromScratch/lab4]$ q Does Azure Functions support rust                      (main|…)  2:10PM
╭───────────────────────────────────────────────────────────────────────────────────────────────╮
│ The Azure Functions for Rust crate supports creating Azure Functions with Rust. The following │
│        Azure Functions trigger bindings are supported: Blob trigger. Cosmos DB trigger.       │
╰───────────────────────────────────────────────────────────────────────────────────────────────╯
selector chosen: snippets1
[mos@core ~/…/elft-net/AzurefromScratch/lab4]$ q what is the kinesis alternative within azure           (main|…)  6:28AM
╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Azure Event Hubs and Amazon Kinesis are two competing cloud services that serve the same purpose │
│     – reliably collect and process massive amounts of data with low latency and at low cost.     │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
selector chosen: snippets1
[mos@core ~/…/elft-net/AzurefromScratch/lab4]$ 
```
Notice: Google is getting totally getting better in this game. Recently it started returning nice, short, up to date snippets where it used to return just JABOLs (just a bunch of links).

- Azure Functions (lab4):
	- Azure Cognitive Services
	- Chatbot
- Azure Container Instance lab  => ACI (lab5)
- Azure Kubernetes Service => AKS (lab6)
- Azure event hubs (lab7)

## Azure Functions
Note: The frameworks for Python and Java SDKs have been depricated and no longer work with the current AZ-CLI we're using
This restricts us to C# and JavaScript, not sure if that's restricting us while the code is running on the server side

Needed some guidance: [ms-bot] (https://learn.microsoft.com/en-us/azure/bot-service/provision-and-publish-a-bot?view=azure-bot-service-4.0&tabs=userassigned%2Ccsharp)

N.B. A more current way to handle chatbots: Power VirtualAgents which should be reachable from Teams. For me it wasn't though and it felt it diverted from the subject.

###Develop Locally
Add chatbots to .NET framework
dotnet new -i Microsoft.Bot.Framework.CSharp.EchoBot
dotnet new -i Microsoft.Bot.Framework.CSharp.CoreBot
dotnet new -i Microsoft.Bot.Framework.CSharp.EmptyBot
dotnet new echobot -n polly
dotnet run
cd polly
dotnet run
start botframework emulator

### Deploy to Azure
az group create --name polly-rg --location westeurope
vi DeploymentTemplates/DeployUseExistResourceGroup/parameters-for-template-AzureBot-with-rg.json
[mos@core ~/…/AzurefromScratch/lab4/polly]$ az deployment group create --resource-group polly-rg --template-file DeploymentTemplates/DeployUseExistResourceGroup/template-AzureBot-with-rg.json --parameters DeploymentTemplates/DeployUseExistResourceGroup/parameters-for-template-AzureBot-with-rg.json

to update: az bot update --resource-group <resource group> --name <azureBotId> --endpoint <messaging-endpoint>





