spawn = require('child_process').spawn
colors = require 'colors'

pipe = (t)->
  t.stdout.on 'data', (da)->
    console.log da.toString()
  t.stderr.on 'data', (da)->
    console.log da.toString()

task 'watch', 'watch the coffee', ->
  t = spawn 'coffee', ['-o', 'lib', '-cw',  'coffee']
  pipe t



# mocha test
test = (callback, env = process.env) ->
  try
    cmd = __dirname + '/node_modules/.bin/mocha'
    process.env.NODE_PATH = process.cwd() + '/lib'
    spec = spawn cmd, ['--compilers','coffee:coffee-script','--colors','--require','should', '-R', 'landing', '--timeout', '3000']
    pipe spec
    spec.on 'exit', (status) -> callback?() if status is 0
  catch err
    console.log err.message.red
    console.log 'Mocha is not installed - try npm install mocha -g'.red

task 'test', 'mocha',->
  test ->
    console.log 'complete'
