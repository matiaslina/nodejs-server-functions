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

## Options

you can change how you run the server. There are three different possibilities for this:

* **npm:** Uses npm (start/stop) internally. This can be useful if you do not want to put the file on the server every time you start vim
* **node-dev:** Uses [node-dev](https://github.com/fgnass/node-dev) to run the server. It's required to install it with the `-g` option. (i.e. `npm install -g node-dev`)
* **bash:** This is the default option. simply runs the node.js server in a bash.

You can change this in your `.vimrc` with:

```
let g:NodejsRunType = "bash" | " this is the default
let g:NodejsRunType = "npm"
let g:NodejsRunType = "node-dev"
```

## How to use

#### Functions

* `:NodejsSetFile <file>`
* `:NodejsStart`
* `:NodejsStop`
* `:NodejsRestart`

First of all you need to set the file that is going to run the server (be /home/user/nodejs-app/app.js the file that runs the server). This is not needed if you set to run the server with `npm`.

```
:cd /home/user/nodejs-app
:NodejsSetFile app.js
```

And then you can use the other three functions to run or stop the server.
