# FabPromo Style Files

These files can be included as submodules to the per-product repos.

To apply the style to the svg files, do the following:

### Add a stylesheet

The stylesheets are named after their category.

```xml
<style type="text/css"><![CDATA[@import url(".../sheet.css");]]></style>
```

### Add the page background

```xml
<use href=".../FabSlide.svg#page" x="0" y="0" />
```

Adjust `x` and `y` so that it matches the pages.

## Build results

Use the `export.bat` script file from the directory where the svg files are.