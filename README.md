# JigSass Utils Type

[![NPM version][npm-image]][npm-url]  [![Dependency Status][daviddm-image]][daviddm-url]   

A dynamically generated set of typesetting utility classes, in charge of modifying
an element's font-size and line-height, based on sizes defined in the
[$jigsass-sizes](https://txhawks.github.io/jigsass-tools-typography/#variable-jigsass-sizes)
variable.

Additionally, JigSass Type provides utility classes for setting an element's
`font-weight`, `font-style` and `font-family` stacks through the 
`$jigsass-font-stacks` variable.

#### Available classes

  - `u-type--<named-size>` (example: .u-type--alpha)
  - `u-fw--<weight>` (example: .u-fw--700)
  - `u-fs--i` (italic)
  - `u-fs--n` (normal)
  - `u-fs--o` (oblique)
  - `u-ff--<stack>` (example: .u-ff--serif)


## Installation

Using npm:

```sh
npm i -S jigsass-utils-type
```

## Configuration
Set named font stacks in `$jigsass-font-stacks`:

```scss
$jigsass-font-stacks: (
  sans-serif: ('Helvetica Neue', Helvetica, Arial, sans-serif),
  serif: (Georgia, Times, 'Times New Roman', serif)
);
```

And then use them as font-family modfiers:

```scss
@include jigsass-util(u-ff, $modifier: serif);
```

## Usage

Import JigSass Utils Type into your main scss file near its very end, together with all
other utilities (utilities should always be the last to be imported).

```scss
@import 'path/to/jigsass-utils-type/scss/index';
```

Like all other JigSass Utils, JigSass Type does not automatically generate any CSS
when imported. You would need to explicitly indicate that each individual typesetting
class should actually be generated in each component or object it is used in:

```scss
// _c.foo.scss
.foo {
  @include jigsass-util(u-type, $modifier: alpha);

  ...
}
```

```scss
// _c.bar.scss
.bar {
  @include jigsass-util(u-type, $modifier: epsilon);
  @include jigsass-util(u-type, $modifier: delta, $from: large);

  ...
}
```

Doing so helps us a great deal with portability, as no matter where we import component or object 
partials, the correct utility classes will be generated. Think of it as a poor man's dependency
management.

Developer communication is also assisted by including "dependencies" wherever they are required,
as anyone going through a partial, can easily understand how it should be marked up with just a
glance.

As far as bloat goes, just don't worry about it - the actual styles will only be generated once, 
at the location in the cascade where the Jigsass Type partial was imported into the main file.



JigSass Type classes are responsive-enabled, using [JigSass MQ](https://txhawks.github.io/jigsass-tools-mq/)
and the breakpoints defined in the [$jigsass-breakpoints](https://txhawks.github.io/jigsass-tools-mq/#variable-jigsass-breakpoints) variable.

Based on the breakpoint arguments passed to `jigsass-util` when including a type class, responsive
modifiers are generated according to the following logic:

```scss
.u-type--modifier[-[-from-{breakpoint-name}][-until-{breakpoint-name}][-misc-{breakpoint-name}]]
```

So, assuming the `medium`, `large` and `landscape` breakpoints are defined in `$jigsass-breakpoints`
as `600px`, `1024px` and `(orientation: landscape)` respectively,

```scss
@include jigsass-util(u-type, $modifier: zeta);
```
will generate the `.u-type--zeta` class, which is not limited to any media-query.

```scss
@include jigsass-util(u-type, $modifier: zeta, $until: medium);
```

will generate the `.u-type--zeta--until-medium` class, which will be in effect at
`(max-width: 37.49em)` and will override styles in the default class until that point.

```scss
@include jigsass-util(u-type, $modifier: zeta, $from: large, $misc: landscape);
```

will generate the `.u-type--zeta--from-large-when-landscape` class, which will go into
effect at `(min-width: 64em) and (orientation: landscape)` and will override styles in the default
class under these  conditions.

Regardless of how many times a class is included, or where, it will only be generated once,
where the `jigsass-utils-type` partial was imported, leaving us with a css file as small
as possible, and a predictable cascade.


## Documentation

The full documentation was generated using mdcss, and is available at 
[https://txhawks.github.io/jigsass-utils-type/](https://txhawks.github.io/jigsass-utils-type/)

## Contributing

It is a best practice for JigSass modules to *not* automatically generate css on `@import`, but 
rather have the user explicitly enable the generation of specific styles from the module.

Contributions in the form of pull-requests, issues, bug reports, etc. are welcome.
Please feel free to fork, hack or modify JigSass Type in any way you see fit.

#### Writing documentation

Good documentation is crucial for usability, scalability and maintainability. When 
contributing, please do make sure that both its Sass functionality (functions, mixins, 
variables and placeholder selectors), as well as the CSS it generates (selectors, 
concepts, usage exmples, etc.) are well documented.

Jigsass Type uses Jonathan Neal's [mdcss](//github.com/jonathantneal/mdcss).

When styles and documentation comments are not automatically generated by your module on `@import`,
please use the `sgSrc/sg.scss` file to enable their generation.

In addition, any file in `sgSrc/assets` will be available for use in the style guide.


## File structure
```bash
┬ ./
│
├─┬ scss/ 
│ └─ index.scss # The module's importable file.
│
├─┬ sgSrc/      # Style guide sources
│ │
│ ├── sg.sccs   # It is a best practice for JigSass 
│ │             # modules to not automatically generate 
│ │             # css and documentation on `@import.` 
│ │             # Please use this file to enable css
│ │             # and documentation comments) generation.
│ │
│ └── assets/   # Files in `sgSrc/assets` will be 
│               # available for use in the style guide
│
└─┬ docs/      # Documention
  │
  └── styleguide/ # Generated documentation 
                  # of the module's CSS
```


**License:** MIT



[npm-image]: https://badge.fury.io/js/jigsass-utils-type.svg
[npm-url]: https://npmjs.org/package/jigsass-utils-type

[daviddm-image]: https://david-dm.org/TxHawks/jigsass-utils-type.svg?theme=shields.io
[daviddm-url]: https://david-dm.org/TxHawks/jigsass-utils-type
