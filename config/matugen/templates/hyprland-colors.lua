local colors = {}
colors.image = "{{image}}"
<* for name, value in colors *>
colors.{{name}} = "rgba({{value.default.hex_stripped}}ff)"
<* endfor *> 

return colors