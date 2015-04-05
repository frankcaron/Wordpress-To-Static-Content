## Wordpress -> Static HTML Export Tool
### A simple utility

So, my Wordpress install got hacked, and I reaized that, in 2015, it's basically pointless 
to operate your own Wordpress install. 

- If you're laymen enough to need Wordpress for a blog, you probably ought to go with the hosted version on Wordpress.org -- or use something like Tumblr.
- If you're fancy schmancy enough, you should probably use a flat-file or static content option like Ghost or Octopress.

I was faced with the proposition of either restoring my WordPress install to subsequently fetch my content, or to write a script that would fetch that content directly from the database so that I could blow away the install.

And here we are.

## Setup

This script requires that you `gem install mysql2`.

## Config

The following changes must be made to `go.rb` before running the script. Note that the script assumes you have a directory created already.

1. Replace the variable values in the "Database" section with your DB details.
2. Change `file_location` to point to the desired directory where you want the post html files created. It's relative to where you run the script.
3. A single CSS file is appended into the files' headers in order to allow for customization after the fact. You can change the name of this file (which you need to manually add if you change it from my example included) by changing `style_css`.

## Usage

Run `go.rb`. The directory will be populated with all of the blog posts as seperate HTML pages.

## Attribution, Thanks, etc.

You're welcome.
