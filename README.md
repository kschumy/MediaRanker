# Media Ranker

## Introduction

In this project, you will build a webapp where users can vote for their favorite pieces of media.

In contrast to previous projects, instead of implementing a pre-defined spec you will be imitating an existing site: http://media-ranker-2-0.herokuapp.com. Your job is to match the functionality and styling of this site as closely as possible.

This is an individual, [stage 2](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md) project.

Due EOD Friday April 13th

## Learning Goals

The purpose of this assignment is to reinforce the following concepts:

- Previous Rails learning, including MVC, RESTful routing, and the request cycle
- Testing Rails applications
- Building complex model logic
- Using `session` and `flash` to track data between requests
- DRYing up Rails code
- Working with a CSS framework
- Styling a page based on an existing design

## Before You Begin

### Provided Files

- `db/media_seeds.csv`: Some starter media to work with
- `app/assets/images/owl.jpg`: The owl picture from the site

### Regarding the Word "Media"

The Rails inflector considers "media" to be the plural of "medium", which is not really what we mean here. You may want to choose a different word to represent "a book, movie or album" internally. The instructor-proved example site uses the word "work".

## Project Requirements

### Core Requirements

Regardless of how you choose to implement this project or how much of it gets done, you should exhibit

- Squeaky-clean **git hygiene**, including
  - A fresh branch for each new feature
  - Regular commits
  - Descriptive commit messages
- Fanatical devotion to **test-driven development**
  - Pseudocode first, then write the tests, then write code to make them pass
- Steadfast adherence to **agile development practices**
  - User stories should be listed and prioritized using a Trello board
  - The finished application should be deployed to Heroku (deploy early, deploy often)
- Unrelenting use of **semantic HTML**

### Baseline

We will begin with some in-class work, exploring the site and pondering implementation details. Before you start writing _any_ code, you should:

- Explore the existing Media Ranker site to become familiar with the necessary functionality
- Create a Trello board to manage user stories
- Create an ERD for the models

Then, once you have a solid plan for how to structure your project:

- Fork and clone the repo
- Use `rails new .` to generate a new Rails project in the cloned directory
  - Verify that the changes we've made to Rails' defaults (postgres as the DB, spec-style testing) have been applied
- `git add .` and `git commit -m "Initial Rails setup"`

### Wave 1

Mimic the site's basic functionality around Media, without worrying (yet) about Users or Votes:
- Build a main page, with a list of the top 10 media of each category, as well as a spotlight section for the top media overall
- Build an index page with a list of all works for each category
- Allow users to add new works
- Build a details page for each piece of media
- Allow users to edit and delete works
- Make sure any models you've built so far are well-tested

### Wave 2

Mimic the site's functionality around Users and Voting:
- Allow users to "log in" to the site, and use the `session` to keep track of which user is currently logged in for a given browser
- Allow users to vote for media, and sort media by vote count whenever a list of media is displayed
- Add a list of voting users to the details page for each media
- Don't allow a user to vote for the same media more than once
- Add a page for each user, as well as a page showing a summary of all users
- Make sure any models you've built so far are well-tested

#### A note on logging in

Passwords and security are tricky! We'll talk about that sort of thing a little in the coming weeks, but for now you don't need to provide any sort of security. The user gives you a username, and your site should just trust them.

### Wave 3

Use Foundation and CSS to style the site to match the example. The layout as well as the look and feel should match as close as possible.

### Optional Enhancement Ideas

Once your test coverage is comprehensive, your HTML is semantic, your user stories have all been moved to the `Done` column and your application has been deployed to Heroku, you may consider the following enhancements.

1. DRY up your code as much as you can! Techniques worth investigating:
    - Helper methods
    - Controller filters
1. Build category-specific pages for `index` and `new` (e.g. `/books` or `/movies/new`). These should be as DRY as possible. You might be interested in investigating _polymorphic routes_.
1. Add a [recommendation system](https://www.toptal.com/algorithms/predicting-likes-inside-a-simple-recommendation-engine) that suggests media to a user based on what they have previously voted for.

## What we're looking for
You can find what instructors will be looking for in the [feedback](feedback.md) markdown document.
