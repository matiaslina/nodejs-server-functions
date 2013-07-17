# Node.js Server Functions

## What's this?

This is a plugin for vim that allows you to **Start**, **Stop** and 
**Restart** a [Node.js](http://www.nodejs.org) server. It contains
just that 3 functions for now, so don't expect magic about this plugin.

## Installation

The best way to install this plugin it's from [Pathogen.vim](https://github.com/tpope/vim-pathogen)

```bash
cd ~/.vim/bundle
git clone https://github.com/matiaslina/nodejs-server-functions
```

## How to use

#### Functions

* `:NodejsSetFile <file>`
* `:NodejsStart`
* `:NodejsStop`
* `:NodejsRestart`

First of all you need to set the file that is going to run the server (be /home/user/nodejs-app/app.js the file that runs the server)

```
:cd /home/user/nodejs-app
:NodejsSetFile app.js
```

And then you can use the other three functions to run or stop the server.
