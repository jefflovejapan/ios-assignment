# Mado Interview Homework Assignment

Hey prospective Mado engineer! We're really excited to get to know you, and we figured a
little homework problem would be a great way to get to know you – and your coding style – better.
Below you'll find a description of what we're looking for, and some constraints we're going to place
on it. This assignment should take **less than 2 hours to complete**.

Once we take a look at your solution, we'll sit down and talk about what you did, how you did it, why you did
it that way, and what you'd work on next if you were to continue to improve your solution.

Good luck, and have fun!

## The assignment

For this assignment we're going to use the public [github api](https://developer.github.com/v3/) to build a small
app. The app will consist of 3 screens:

1. Username entry screen
2. User overview
3. Repo details

You can connect all of these screens as you see fit.

First we'll talk about the general requirements, after that what each screen should do.

## General Requirements

- The application **must** be written in Swift, preferably the latest version available (currenlty v4.0).
- Network calls **must not** block the main thread. Feel free to use whatever networking library is most comfortable to you, or none at all.
- Implement at least one of the three screens in a `.xib`.
- Implement at least one of the three screens without using a `.xib`.
- Don't use a pre-packaged github library, please make the calls yourself.

Feel free to use this repo as a starting point, or to start your own if you don't like the template we used (the built in iOS "Single View App").

## Screen Requirements

### Username entry screen
This screen should accept a github username (like `nsillik`). You should show an error if the user doesn't
exist. If the user does exist, you should move on to the next screen.

### User overview
This screen should show information about the user, as well as a list of the user's repositories. You can do
this any way you please. The information about the user should include:

- The user's name and username
- The user's avatar
- The date the user joined github

Somewhere there should be a **tappable** list of repos that the user has. This should include, for each repo, the following:
- The repo name
- The repo description
- The number of stars and forks

### Repo details
The repo details screen is your time to shine! It should include at least the following:

- The repo name
- The repo description
- The number of stars and forks
- The git clone URLs.

Other than that, feel free to include whatever information you want. The diff of the last commit, a list
of all collaborators, open issues? It's up to you, have fun!
