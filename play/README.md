# The second brain dilemma
The OpenAI API doesn't provide the option to keep context which makes it imposible to build upon the previous answer. One could could add the previous prompt to the current one but that does not exactly lead to the desired result. Another option which is worth researching is to build your personal vertical in front of the OpenAI API. The Tensor framework is needed to accomplish this. This framework has proprietary GPU-modules and is not included in the Fedora distribution as such. Trying boldly to get the framework compiled failed. The response from the TensorFlow team:
```
chunduriv
TensorFlow Team
Dec '22
Unfortunately we don’t provide build support for Fedora 37. Currently we are supporting the following OS

Ubuntu 16.04 or higher (64-bit)
macOS 10.12.6 (Sierra) or higher (64-bit) (no GPU support)
Windows Native - Windows 7 or higher (64-bit) (no GPU support after TF 2.10)
Windows WSL2 - Windows 10 19044 or higher (64-bit)
Thank you!
```
Which coners me to a probably expensive cloud solution . . . . . 
```
[mos@core ~]$ q does python in AzureFunctions support the TensorFlow framework (:|✔)  5:17PM
I'll assume you meant this: does python in Azure Functions support the TensorFlow framework
╭──────────────────────────────────────────────────────────────────────────────────────╮
│ Azure Functions recently announced the general availability of their Python language │
│   support. We can use Python 3.6 and Python's large ecosystem of packages, such as   │
│                      TensorFlow, to build serverless functions.                      │
╰──────────────────────────────────────────────────────────────────────────────────────╯
selector chosen: snippets1
[mos@core ~]$
```
Considering how to proceed . . . . 
