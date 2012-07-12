spawn = require('child_process').spawn

pipe = (t)->
  t.stdout.on 'data', (da)->
    console.log da.toString()

task 'watch', 'watch the coffee', ->
  t = spawn 'coffee', ['-o', 'lib', '-cw',  'coffee']
  pipe t



