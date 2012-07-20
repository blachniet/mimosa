util =     require './util'
logger =   require '../util/logger'
Watcher =  require './util/watcher'

virgin = (opts) =>
  util.processConfig false, watch, true

watch = (config) ->
  config.virgin = true
  compilers = util.fetchConfiguredCompilers(config, true)
  new Watcher(config, compilers, true)

register = (program, callback) =>
  program
    .command('virgin')
    .description("compile and lint assets but do not write the output")
    .action(callback)
    .on '--help', ->
      logger.green('  Mimosa without the extra kick.  The virgin command will observe your source directory, compile your')
      logger.green('  assets when they change, and lint the output, but it will not write the result, start a server or ')
      logger.green('  perform any RequireJS optimizations.  Use this is if you already have a server and an "asset pipeline",')
      logger.green('  but want the instant compilation feedback and the linting.')
      logger.blue( '\n    $ mimosa virgin\n')

module.exports = (program) ->
  register(program, virgin)