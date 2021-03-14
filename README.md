# Setup

Comprehensive setup guide with automated scripts to get your developer onboarded from days to hours!

Setting up your environment can be frustrating! Sometimes, you want to make sure you setup just the right amount before asking questions too. That's why I have created this Github repo for the onboarding process. Currently this is for Mac environments, but I hope to add more in the near future. I have a grand list of todo items for this work but wanted to get the bare minimum: 

Special shotout to @bradp for his [gist](https://gist.github.com/bradp/bea76b16d3325f5c47d4) and [thoughtbot](https://github.com/thoughtbot/laptop) that inspired me to create this repo! 


## TODO 
- Have setup scripts for other environments: 
  - [ ] Windows
  - [ ] Linux   

## How to run 

### Option 1 

Download the script:

```
curl --remote-name https://raw.githubusercontent.com/farmanp/setup/main/mac_setup
```

Review the script (avoid running scripts you haven't read!):

```
less mac_setup
```

Execute the downloaded script:

```
sh mac 2>&1 | tee ~/mac_setup.log
```

Optionally, review the log:

```
less ~/mac_setup.log
```

### Option 2

Copy and paste the file locally and run the script on your local environment. 
