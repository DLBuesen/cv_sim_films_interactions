using Interact
using Blink

ui = button()

fp = filepicker()

tb = textbox("Write here")


#display(ui)

w = Window()
body!(w, ui)

o = observe(ui)
on(n -> println("Hello!"), o)

f = observe(fp)
# on(n -> println("Hello!"),f)
on(n -> println("$f"),f)

t = observe(tb)
on(t -> println("$t"),t)
