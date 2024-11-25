Verbformen Data for German Vocabularies
=======================================

In addition to Wiktionary, wilhelm-graphdb also sources German vocabularies from
[verbformen.com](https://www.verbformen.com), because one day I found from my German textbook a word __Sparpreise__ that
is [not found in Wiktionary](https://en.wiktionary.org/wiki/Sparpreise). Then I realize the the importance of multiple
sources for a language.

The reason for choosing [verbformen.com] is because of its comprehensive inflection info of German vocabulary provided. 

### Verb Conjugation

The conjugation is the inflection paradigm for a German verb. Those with `conjugation` field denotes a __verb__; its
definition also begins with an _indefinite form_, i.e. "to ..."

There are __3__ persons, __2__ numbers, and __4__ moods (indicative, conditional, imperative and subjunctive) to
consider in conjugation. There are __6__ tenses in German: the present and past are conjugated, and there are four
compound tenses. There are two categories of verbs in German:
[weak and strong](https://en.wikipedia.org/wiki/Germanic_strong_verb)[^1]. In addition,
[strong verbs are grouped into 7 "classes"](https://en.wikipedia.org/wiki/Germanic_strong_verb#Strong_verb_classes)

[^1]: https://en.wikipedia.org/wiki/German_verbs#Conjugation

The conjugation table of German verb on Wiktionary is hard to interpret for German beginner. It does, however, presents
a very good Philology reference. For example, it tells us which of the 7 "classes" a strong verb belongs to. __We,
therefore, leave the Wiktionary links to the conjugation table of that verb for data processing in the future__, for
example,

```yaml
  - term: aufwachsen
    definition: to grow up
    conjugation: https://en.wiktionary.org/wiki/aufwachsen#Conjugation
```

and advise user to employ a much more practical method to learn daily conjugation as follows. We take "__aufwachsen__"
as an example.

> [!IMPORTANT]
> I'm not advertising for any organizations. I'm simply sharing good resources.

[Netzverb Dictionary](https://www.verbformen.com/) is the best German dictionary _targeting the vocabulary inflections_.
[Search for "aufwachsen"](https://www.verbformen.com/?w=aufwachsen) and we will see much more intuitive conjugation
tables listed.

This pretty much serves our needs, but what makes Netzverb unpenetrable by other alternatives is that _every_ verb comes
with

1. [A printable version that looks much better than the browser's Control+P export](https://www.verbformen.com/conjugation/aufwachsen.pdf)

   - There is also a "Sentences with German verb aufwachsen" section with a
     [link](https://www.verbformen.com/conjugation/examples/aufwachsen.htm) that offer a fruitful number of conjugated
     examples getting us familiar with the inflections of the verb

2. [An on-the-fly generated flashcard sheet](https://www.verbformen.com/conjugation/worksheets-exercises/lernkarten/aufwachsen.pdf)
   which allows us to make a better usage of our random free time
3. [A YouTube video that offers audios of almost every conjugated form](https://www.youtube.com/watch?v=LCtUrSn030A),
   which helps with pronunciations a lot

> [!TIP]
>
> - __It is, thus, strongly recommended to study the conjugation through
>   [Netzverb Dictionary](https://www.verbformen.com/) separately__
> - Netzverb Dictionary, however, lacks a programmable API. Wiktionary [has a good one](https://dumps.wikimedia.org/)
>   instead. This is why we left the conjugation link to Wiktionary for now and it will definitely serve us well as I'm
>   trying to make it happen

### Crawling [verbformen.com]

The current solution is to use [dict.cc](https://www1.dict.cc/translation_file_request.php?l=e) as a reference of word
list. Each word is that list is fed into verbformen search in a Scrapy crawler:

```console
cd verbformen
scrapy crawl verbformen
```

[verbformen.com]: https://www.verbformen.com
