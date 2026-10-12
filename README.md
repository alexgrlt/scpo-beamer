# scpo-beamer

A [Quarto](https://quarto.org) **revealjs** template for academic talks in the
Sciences Po (Department of Economics) visual identity: ScPo logo on the title
slide, shield in the footer, ScPo red and grey, Yanone Kaffeesatz titles and
Droid Serif body text.

The slide layout is adapted from the R Markdown slides of
[ScPoEcon/ScPoEconometrics-Slides](https://github.com/ScPoEcon/ScPoEconometrics-Slides),
ported here to Quarto. See [Credits](#credits).

Despite the name it does not use LaTeX Beamer: slides are written in Markdown
(`.qmd`), rendered to HTML, and can be exported to PDF from the browser.

`example.qmd` is a working deck that shows every feature of the template, one
per slide. The quickest way to learn the template is to render it and read
its source side by side.

---

## Contents

```
scpo-beamer/
├── example.qmd          Example deck showing every feature; copy it to start a talk
├── example.bib          Bibliography used by the example
├── img/                 Your figures (two placeholders used by the example)
├── assets/              Template files; you normally don't edit these
│   ├── css/
│   │   ├── scpo.css         Main stylesheet: layout, title slide, images, tables,
│   │   │                    special slides, buttons
│   │   ├── scpo-fonts.css   Fonts (Google Fonts) and inline-code styling
│   │   └── callout.scss     Quarto theme layer for the custom .callout-question
│   │                        (see Known issues)
│   ├── filters/
│   │   └── uncounted_appendix.lua   Slides after "# Appendix {.appendix}"
│   │                                are left out of the slide count
│   ├── includes/
│   │   └── header.html      Loads Font Awesome 6 Free from a public CDN (icons)
│   └── logos/
│       ├── ScPo-econ.png    Logo at the top left of the title slide
│       └── ScPo-shield.png  Shield in the footer of every slide
├── README.md
└── LICENSE              CC BY-SA 4.0, inherited from ScPoEconometrics-Slides
```

---

## Requirements

- A recent **Quarto** (the example was test-rendered with Quarto 1.7.32).
- **R** with `knitr` and `rmarkdown`, only if the deck has executable R chunks
  (the example has one). A deck without code chunks needs only Quarto.
- An **internet connection** when presenting: fonts, Font Awesome and MathJax
  are loaded from CDNs. For an offline talk, add `embed-resources: true` under
  `revealjs:` in the YAML header (this makes a single, larger HTML file).

---

## Quick start

1. Copy the template into a new folder (or use it as a GitHub template), and
   rename `example.qmd`:

   ```bash
   git clone git@github.com:alexgrlt/scpo-beamer.git my-talk
   cd my-talk
   mv example.qmd my-talk.qmd
   ```

2. Edit the YAML header (title, subtitle, author, `bibliography:`), delete the
   example slides you don't need, write yours.

3. Preview with live reload, or render once:

   ```bash
   quarto preview my-talk.qmd
   quarto render  my-talk.qmd    # -> my-talk.html
   ```

Keep the **`assets/` folder next to the `.qmd`**: the YAML header and
`scpo.css` refer to it with relative paths. Put your own figures in `img/`.

---

## The YAML header

The parts that make the template work. Keep them as they are unless you know
why you are changing them.

```yaml
format:
  revealjs:
    theme:
      - "assets/css/callout.scss"            # custom callout layer
    width: 1600                              # 16:9 canvas
    height: 900
    margin: 0.05
    slide-number: true
    css:
      - "assets/css/scpo.css"
      - "assets/css/scpo-fonts.css"
    footer: |                                # shield on every slide
      <div class="my-footer"><img src="assets/logos/ScPo-shield.png" style="height: 60px;"/></div>
    include-in-header:
      - "assets/includes/header.html"        # Font Awesome
filters:
  - assets/filters/uncounted_appendix.lua    # uncounted appendix
bibliography: your-file.bib
execute:
  echo: false                                # hide code by default
  warning: false
  message: false
```

LaTeX macros you want on every slide go in a hidden block at the top of the
document (see the example's `\independent` and `\E`):

```markdown
::: {.hidden}
$$
\newcommand{\E}{\mathbb{E}}
$$
:::
```

---

## Cheat sheet

### Slide structure

| Markdown | Result |
|---|---|
| `# Section title` | Centred section divider (red title on white). |
| `## Slide title` | A normal slide. |
| `## Title {#my-anchor}` | A slide you can link to (see buttons below). |
| `# {.standout-red background-color="#d90502"}` | Full red slide, centred white text, no title. Used for the opening hook and "Thank you!". |
| `## Title {.title-slide-section-red background-color="#d90502"}` | Full red, centred divider *with* a title. |
| `## Title {.title-slide-section-grey background-color="#515151"}` | Same, in ScPo grey. |
| `## Title {.inverse background-color="#ffebf0"}` | Light pink background, blue titles: a recap or an aside. |
| `## {.standout}` | One centred message on a white slide. |
| `# Appendix {.appendix}` | Starts the appendix; every slide after it is uncounted. |
| `::: notes` … `:::` | Speaker notes (press **S** during the talk). |

The `background-color` attribute is optional, but without it a coloured slide
is drawn inside the slide margins and leaves a thin white frame around it.

### Text

| Markdown | Result |
|---|---|
| `**bold**` | Bold **and ScPo red**. |
| `[text]{.blue}` | Bold blue. Also `.grey`, `.lightgrey`, `.black` (bold), `.white`, `.forestgreen`, `.ScPored`. |
| `` `code` `` | Monospace on a light red background. |
| `^[A footnote.]` | Footnote at the bottom of the slide. |
| `> quote` | Blockquote with a grey rule. |

### Revealing content

| Markdown | Result |
|---|---|
| `. . .` on its own line | Pause: what follows appears on the next click. |
| `::: {.incremental}` around a list | One item per click. In an **ordered** list, items already shown fade to 25% opacity. |
| `incremental: true` in the YAML | Every list is incremental. |

### Columns

```markdown
::: {.columns .cols-40-60}
::: {.col}
Left
:::
::: {.col}
Right
:::
:::
```

Without a `.cols-*` class the columns share the width equally. Available
splits: `.cols-40-60`, `.cols-30-70`, `.cols-35-65`.
The older floats `::: {.pull-left}` / `::: {.pull-right}` (48% each) still
work; `::: {.left-column}` / `::: {.right-column}` give a 25 / 70 split.

### Callouts

```markdown
::: {.callout-note title="Note"}
Content.
:::
```

Quarto's built-in `callout-note`, `callout-tip`, `callout-warning`,
`callout-important` and `callout-caution` all work.

### Images

Classes go in braces after the image: `![](img/figure.png){.vw60}`.

| Class | Effect |
|---|---|
| *(none)* | Fits within 70% of the screen height. |
| `.vw50` `.vw60` `.vw70` `.vw90` | Width = 50 / 60 / 70 / 90% of the screen, centred. |
| `.vh70` | Height = 70% of the screen. |
| `.col` | Fits the width of its column. |
| `.col-center` | Centred in its column, caption underneath. |
| `.corner-br` / `.corner-br-lg` | Pinned to the bottom-right corner, caption above. |
| `.fullslide` | Fills the whole slide (use on a slide with an empty title: `## {.nostretch}`). |
| `.inline` | Icon-sized image inside a line of text. |
| `::: {.img-duo}` around two images on one line | Two images side by side, full height. |
| `::: {.grille-4}` around two `.col` with two images each | 2 × 2 grid. |

**Add `{.nostretch}` to the slide title** whenever an image has a caption or
uses `.col-center`, `.corner-br*` or `.fullslide`. Otherwise Quarto
auto-stretches a lone image to fill the slide and drops the `<figure>` wrapper
these classes rely on.

### Figures computed in R

Size them with chunk options rather than CSS classes:

````markdown
```{r}
#| label: my-plot
#| fig-width: 13
#| fig-height: 5
ggplot(...)
```
````

`#| classes: vw90` puts the class on the chunk's wrapper `<div>`, not on the
image, so the image classes above do **not** apply that way. To put a class
on the image itself, `#| out-extra: ".vw90"` should work (Quarto passes
`out-extra` into the image's attributes).

### Tables

Wrap a Markdown table in a div:

```markdown
::: {.fine-lines .smaller-reg}
| A | B |
|---|---|
| 1 | 2 |
:::
```

| Class | Effect |
|---|---|
| `.small-reg` / `.smaller-reg` | Table text at 85% / 75%. |
| `.scale-75` / `.scale-50` | Shrink the whole table (from its top-left corner). |
| `.fine-lines` | Thin grey horizontal rules only, heavier rule under the header. |
| `.no-lines` | No rules at all (regression tables). |

### Code

````markdown
```{.r code-line-numbers="3-4"}
...
```
````

highlights lines 3–4. Show the code of an executed chunk with `#| echo: true`.

### Navigation buttons

```markdown
[Details in the appendix](#app-details){.button}            <!-- red -->
[Back](#main-slide){.button .back}                         <!-- grey -->
```

Give the target slide an anchor (`## Title {#app-details}`). A slide without
an explicit anchor can be reached by its auto-generated id (roughly its title
in lowercase, punctuation dropped, spaces replaced by hyphens). In the PDF export the buttons print as
plain labels.

---

## Customising

The main settings are CSS variables at the top of `assets/css/scpo.css`:

| Variable | Default | Controls |
|---|---|---|
| `--scpo-red`, `--scpo-grey`, `--scpo-blue`, … | ScPo palette | Colours used everywhere. |
| `--slide-font-size` | `1.75em` | Base text size. |
| `--title-logo-url` | `../logos/ScPo-econ.png` | Logo on the title slide (path relative to `scpo.css`). |
| `--title-logo-height` | `120px` | Its height. |
| `--title-logo-margin-left` | `0px` | Its distance from the left edge. |
| `--footer-left`, `--footer-transform` | centred | Position of the footer shield (comments in the file give left / right variants). |
| `--footnote-font-size` | `85%` | Footnote size. |

To use another logo, replace `assets/logos/ScPo-econ.png`, or point
`--title-logo-url` to a different file. To change the footer, edit `footer:`
in the YAML header.

---

## Exporting to PDF

1. Render the deck and open the HTML file in Chrome or Chromium.
2. Add `?print-pdf` to the URL (e.g. `my-talk.html?print-pdf`) and reload.
3. Print → *Save as PDF*, landscape, margins *None*, background graphics on.

`scpo.css` has `.print-pdf` rules so that coloured slides, corner images and
buttons print correctly. [DeckTape](https://github.com/astefanutti/decktape)
also works: `decktape --size 1600x900 reveal my-talk.html my-talk.pdf`.

---

## Known issues

- **`.callout-question` does not render as a callout in recent Quarto.**
  Quarto 1.7 only turns `note`, `tip`, `warning`, `important` and `caution`
  into callouts: `::: {.callout-question}` comes out as a plain block of text,
  and adding it next to a built-in type (`{.callout-note .callout-question}`)
  does not help because Quarto strips every `callout-*` class. `callout.scss`
  also targets `.callout-captioned`, which Quarto now calls `.callout-titled`.
  Until this is reworked, use one of the built-in types.
- **Quarto's own callout styling wins.** The callout rules in `scpo.css`
  (14px rounded corners, 6px borders, red border for warnings) are overridden
  by Quarto's theme: callouts keep Quarto's 4px corners and colours (warnings
  are yellow, not red).
- **`.img-duo`** uses a `--slide-title-height` variable that is never defined;
  its height declaration is ignored and the images size themselves.
- The footer shield is a PNG without transparency, so it shows as a white
  square on red and grey slides.

---

## Credits

- **Slide layout.** The layout, colours, fonts and many of the CSS classes
  (`.pull-left`/`.pull-right`, `.left-column`/`.right-column`, `.inverse`,
  the colour helpers, the title slide and section dividers) are adapted from
  the R Markdown slides of the Sciences Po econometrics course,
  [ScPoEcon/ScPoEconometrics-Slides](https://github.com/ScPoEcon/ScPoEconometrics-Slides),
  released under the
  [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).
  This repository ports that `.Rmd` template to Quarto revealjs.
- **Custom callout.** `callout.scss` is based on a Stack Overflow answer by
  Shafee (CC BY-SA 4.0), as noted at the top of the file.
- **Logos.** `ScPo-econ.png` and `ScPo-shield.png` are Sciences Po marks and
  remain the property of Sciences Po.

## License

[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), the license
of the ScPoEconometrics-Slides material this template adapts: you may reuse and
modify it with credit, and must share adaptations under the same license. The
Sciences Po logos are excluded. See `LICENSE`.
