---
date: 2017-04-21T00:11:02+01:00
title: Getting started
weight: 10
---

## Installation

### macOS 
```bash
brew install sweady
```
### Linux
```bash
wget xxx && chmod +x
```

## Setup

You must move to the folder where you want to manage the Sweady configuration.
```bash
sweady init
```

## Configuration
The previous step generates a ``` sweady_config.json ``` file that will contain all of the information needed to build your Sweady cluster.
   
Once you have finished the configuration, you must run this command:

```bash
sweady create
```
