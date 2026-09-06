# Ikura

Ikura takes away all the ceremony from syntax highlighting. No need to setup an LSP or open up config files; just pop open Ikura and tell it what keywords to track and what conjunctions (we'll get into what those are later) to track. Then, you just insert a code example and select some colors and you have an example ready!

The main point of Ikura is to demonstrate your language designs. Later, I may add functionality for Ikura to output an actual syntax highlighter that can be used for VS Code, but for now it's only for demonstrations. The thought is that demonstrating language designs without syntax highlighting makes it harder for your audience to read/parse it, as well as making it look less professional.

However, you shouldn't have to write a .yaml or other config file just for the sake of a demonstration; you should be able to apply syntax highlighting to your language design in 5-10 minutes.

In Ikura, words are broken up into three categories:
- Keywords
- Conjunctions
- Literals

Keywords are things like `echo` in PHP or `let` in JavaScript. 

Conjunctions are things like `do` in Ruby or `in` in OCaml.

Literals are strings, integers, and other primitives.

I'm not going to explain anything else other than the installation because Ikura is pretty straightforward and visual.

Below is a guide on installing Ikura.

Ikura is self-hosted, meaning you have to launch the process yourself.

First, you'll want to get the source code. Do that by git cloning this repo into a new directory, and then cd into it.

My preferred way to use Ikura is through serve. Any other way will work too.

Once you have it up and running on localhost, go to the url and you should be able to figure out the rest from there.

Cheers!
