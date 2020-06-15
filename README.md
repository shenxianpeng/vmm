# VMM

Jenkins integration with virtual machine management (VMM)

## Requirements

Realize regular batch login to remote virtual machines and then perform some specified operations, and also support users to add new hostname.

A simple shell script can achieve regular ssh login operations, but how to achieve more elegant will take some time, such as:

* Regular automatic execution
* Output more intuitive login test results
* Support users to add new hostname to the list to be checked
* After the execution is completed, notify the user and so on.

Refer to the repository code. Please note that the code here is just an example, and there may be some execution failures, but I think you'll be able to fix them very soon.

## How it works like?

1.Pipeline start

  ![](img/pipeline-start.png)

2. Pipeline result
  ![Pipeline result](img/pipeline-result.png)
  
3. Archive file

  ```
  #####################################################
  ######### VM login check via SSH results ############
  #####################################################
  #                                                   #
  # Compelted (success) 14/16 (total) login vm check. #
  #                                                   #
  # Below 2 host(s) login faied, need to check.       #
  #                                                   #
       abc.company.com 
       xyz.company.com 
  #                                                   #
  #####################################################
  ```
