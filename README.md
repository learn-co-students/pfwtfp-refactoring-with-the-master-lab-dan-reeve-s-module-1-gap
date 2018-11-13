# Refactoring with the Master

## Learning Goals

- Recognize how refactoring code improves readability
- Modify expressions and statements while maintaining functionality

## Introduction

The term "refactoring" was established by [Martin Fowler] who [defines it][def]
thus:

> In my refactoring book, I gave a couple of definitions of refactoring.
>
> Refactoring (noun): a change made to the internal structure of software to make
> it easier to understand and cheaper to modify without changing its observable
> behavior.
>
> Refactoring (verb): to restructure software by applying a series of
> refactorings without changing its observable behavior.

Fowler underscores a critical point: code can be done and work, but still be
hard to understand and expensive (in time and money) to modify. The goal of
_refactoring_ then is to make code that's hard to understand and expensive
easier to understand and modify.

The process of refactoring is:

- Building or inheriting a test: This may be using a test framework or having a
  way to test "does this code work as it is written currently?"
- Passing the test
- Changing the internals of the code _without breaking the test_
  - No _new_ features are added
  - Code might run faster, but more importantly it's easier to reason about

Learning to build tests that can be run quickly to verify function of your code
is a career-long study for developers. For the purposes of this lesson, you'll
inherit reasonably good tests for testing the application. You'll **also** be
given a _working_ solution (nice for a change!). Through a series of code
reviews you'll edit the code internals to be cleaner, simpler, and easier to
read. In fact, you'll learn how to cut away _nearly half the code_ and still
have it work!

### Modify Expressions and Statements While Maintaining Functionality

The code provided in the `lib` folder currently passes all tests found in the
`original_spec` folder. You can verify this by running
`rspec original_spec --format d` in your terminal. However, to pass this lab,
you must write code that passes all tests found in `spec`. The resulting code
should pass all original and new tests, showing that functionality has not
changed after refactoring.

Your process should be the following:

- Run `rspec original_spec --format d` to verify the tests pass
- Read the code review feedback (more on that below)
- Try to implement the code changes in the corresponding `lib` file
- Verify the tests are still passing
- Compare your solution to ours
- Make adjustments (if any)
- Verify the tests are still passing

### Starting Code: `lib/luck_analyzer.rb`

Take a look at the `LuckAnalyzer` class. Take a look at the specs in
`original_spec`. You can form a sense for how the existing code works. It is
this `lib/luck_analyzer.rb` file that you send to the master.

## The First Encounter: Extract Method

**Given**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/1.pdf" target="_blank">First Sample</a>

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/1-annotated.pdf" target="_blank">First Sample Annotated</a>

The Master is encouraging us to apply a refactoring known as **Extract
Method**. This is one of the most important refactorings. The Master suggests
that we take a bit of code that appears in multiple places, put it in a method
and then call _that_ instead of re-running its implementation multiple times.

Here's a [diff][diff1] that shows the change. The updated code looks
like <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/2.pdf" target="_blank">the following</a>.

> **Process Reminder**: Be sure to re-run the original specs (`rspec original_spec --format d`) and make sure they still run without error. This change,
> while it might seem small, reduced our code by 16 lines. That's 12% less code
> to have a bug in it!

## The Second Encounter: Extract Method

**Given**: <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/2.pdf" target="_blank">Second Sample</a>.

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/2-annotated.pdf" target="_blank">Second Sample Annotated</a>

The Master **again** suggests we apply **Extract Method**. We're doing the same
calculation twice making for repeated code. As programmers, we prefer "DRY"
(Don't Repeat Yourself) code.

Given that they have recommended **Extract Method** twice, we should be extra
mindful to make sure we're very comfortable with it!

Here's a [diff][diff2] that shows the change. The updated code looks
like <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/3.pdf" target="_blank">the following</a>.

## The Third Encounter: "Work Clean"

**Given**: <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/3.pdf" target="_blank">Third Sample</a>

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/3-annotated.pdf" target="_blank">Third Sample Annotated</a>

![Bourdain](https://media.giphy.com/media/l1J3uKOu6ZhGPW7RK/giphy.gif)

The great programmer Anthony Bourdain remarked that great mise-en-place chefs
"work clean." They keep their station clean, their knives clean and at hand,
they have a stack of service towels ready. They don't let distraction or
clutter get in their station. Their minds need to be focused on the task at
hand and if someone, someone's cell phone, someone else's mess is in their
place...that problem will get solved.

In their feedback, The Master is suggesting here that this code is not "working
clean." It passes the spec, sure, but it _hides_ some of what it's doing with
confusing / non-essential extra code (or, "noise"). The Master is asking us to
remember to be Mindful as we code.

We should trim it down. This uses a few known refactorings:

- Remove Temporary Variable
- Remove Unused Code

At the end, our implementation looks like:

```ruby
  def least_trials_slice
    minimum_pair = nil

    name_to_trials_count.each do |pair|
      minimum_pair = pair if minimum_pair.nil?
      minimum_pair = pair if minimum_pair[1] > pair[1]
    end
    minimum_pair
  end
```

Here's a [diff][diff3] that shows the change. The updated code looks
like <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/4.pdf" target="_blank">the following</a>.

## The Fourth Encounter: Know Your `Enumerable`s

**Given**: <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/4.pdf" target="_blank">Fourth Sample</a>

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/4-annotated.pdf" target="_blank">Fourth Sample Annotated</a>

The Master repeats something we say at Flatiron School all the time: **KNOW YOUR
`ENUMERABLE`S**. While the Third Encounter made some of our code better, it
revealed that we were basically doing something that _Ruby knew how to do for
us_ all along!

Prepare to be staggered, but as of this change, original implementation has
gone from being `19` lines long to being exactly `1`, defined, line.

Also, intuition suggests that if there's a `min_by`, there's also a `max_by`.
Consulting the docs shows it to be so. Let's fix `most_trials_candidate` to use
`max_by` as well.

Here's a [diff][diff4] that shows the change. The updated code looks
like <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/5.pdf" target="_blank">the following</a>.

## The Fifth Encounter: Remember Your Constructor Methods

**Given**: <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/5.pdf" target="_blank">Fifth Sample</a>

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/5-annotated.pdf" target="_blank">Fifth Sample Annotated</a>

The Master notes here that we're doing a verbose implementation of a common
pattern known as an "auto-vivifying `Hash.`" It's described in the Ruby `Hash`
[documentation][hashdoc] as:

> Hashes have a default value that is returned when accessing keys that do not
> exist in the hash. If no default is set nil is used. You can set the default
> value by sending it as an argument to ::new:

Here's a [diff][diff5] that shows the change. The updated code looks
like <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/6.pdf" target="_blank">the following</a>.

## The Sixth Encounter: `#reduce`

**Given**: <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/6.pdf" target="_blank">Sixth Sample</a>

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/6-annotated.pdf" target="_blank">Sixth Sample Annotated</a>

The `Enumerable` method `#reduce` is a bit confusing but very powerful. It's
designed to combine elements in an `Enumerable` to a new value or new data
structure (like an `Array` or a `Hash`).

Here the Master points out that we're re-implementing the tricky `#reduce`
method. Consulting the docs and practicing in IRB gives us the confidence to
make the change. Again, make sure the specs are still passing for yourself!

Here's a [diff][diff6] that shows the change. The updated code looks
like <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/7.pdf" target="_blank">the following</a>.

## The Seventh Encounter: Aesthetics Count

**Given**: <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/6.pdf" target="_blank">Seventh Sample</a>

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/7-annotated.pdf" target="_blank">Seventh Sample Annotated</a>

Human beings developed a sense for symmetry and balance so that we could judge
health of other humans. This powerful sense can also help us keep code
beautiful. This encounter suggests that if you do something in one way for
_yin_, you should do the same thing, but slightly reversed for _yang_.

![Yin and Yang](https://media.giphy.com/media/FPjJbmGUVZmC92zO4c/giphy.gif)

This strengthens a software design concept called
["The Principle of Least Surprise."][pols] If I say "right" you expect there to
be a "left." If I say there's a "bottom," then somewhere there ought be a
"top." But how weird, or _surprising_ would it be if "left" and "right"
returned slightly different things. The Master wants us to avoid creating
surprises like this.

Here's a [diff][diff7] that shows the change. The updated code looks
like <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/8.pdf" target="_blank">the following</a>.

## The Eighth Encounter: Pulling it Together

**Given**: <a href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/8.pdf" target="_blank">Eighth Sample</a>

**Returned**: <a
href="https://curriculum-content.s3.amazonaws.com/pfwtfp/pfwtp-refactoring-with-the-master-lab/8-annotated.pdf" target="_blank">Eighth Sample Annotated</a>

The Master's last message is some tough medicine, but, they're right: this
looks _so_ sloppy compared to everything above that they've guided us on. Let's
try to use the techniques we've seen in previous encounters to get a final,
new, test to pass.

Running `learn` will run a final spec that will encourage us to create a
beautiful implementation. You can always run `rspec original_spec` to make
sure you didn't break things (this is why refactoring code with tests is so
much easier!). When both `rspec original_spec` and `learn` pass you'll truly
have understood the Master's teachings.

## Conclusion

Refactoring is the process of making code correct and easy to maintain. For
many this would be the definition of "good code." With additional study you can
learn the refactorings that Fowler and others have researched. These are
tested solutions for untangling complex code.

## Resources

- [Refactoring (book)][book]

[martin fowler]: https://martinfowler.com/
[def]: https://martinfowler.com/bliki/DefinitionOfRefactoring.html
[book]: https://martinfowler.com/books/refactoring.html
[hashdoc]: https://ruby-doc.org/core-2.2.0/Hash.html
[pols]: https://en.wikipedia.org/wiki/Principle_of_least_astonishment
[diff1]: https://github.com/learn-co-curriculum/pfwtfp-dice-thrower-from-a-file/commit/458f57f91cd7461312407d0d558ef3f945110bf6?diff=unified
[diff2]: https://github.com/learn-co-curriculum/pfwtfp-dice-thrower-from-a-file/commit/846bdc469d0fdf5ea48ad58b67718b1f63f195ec?diff=unified
[diff3]: https://github.com/learn-co-curriculum/pfwtfp-dice-thrower-from-a-file/commit/846bdc469d0fdf5ea48ad58b67718b1f63f195ec?diff=unified
[diff4]: https://github.com/learn-co-curriculum/pfwtfp-dice-thrower-from-a-file/commit/2854579d6556287864447298b5a4fed8b2013a53?diff=unified
[diff5]: https://github.com/learn-co-curriculum/pfwtfp-dice-thrower-from-a-file/commit/d13a32b5c809908a6e55ebf88eab4fade6edf9d0?diff=unified
[diff6]: https://github.com/learn-co-curriculum/pfwtfp-dice-thrower-from-a-file/commit/ea0aa7f354580b7e6b11e12bce899232275637e9?diff=unified
[diff7]: https://github.com/learn-co-curriculum/pfwtfp-dice-thrower-from-a-file/commit/c0f62593665f694795844cd892fea07e9ed1abc5?diff=unified
