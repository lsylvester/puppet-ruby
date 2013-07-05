# Installs ruby 1.8.7p357 from rbenv.
# On 10.8 disables tk, tcl, and tcltk.
#
# Usage:
#
#     include ruby::1_8_7_p357
class ruby::1_8_7_p357 {
  require gcc

  case $::osfamily {
    Darwin: {
      include boxen::config

      $default_env = {
        'CC' => "${boxen::config::home}/homebrew/bin/gcc-4.2"
      }

      case $::macosx_productversion_major {
        '10.8': {
          $env = merge($default_env, {
            'CONFIGURE_OPTS' => '--disable-tk --disable-tcl --disable-tcltk-framework'
          })
        }

        '10.9': {
          $env = merge($default_env, {
            'CONFIGURE_OPTS' => '--disable-tk --disable-tcl --disable-tcltk-framework',
            'CC'             => 'gcc-48'
          })
        }

        default: {
          $env = $default_env
        }
      }
    }

    default: {
      $env = {
        'CC' => 'gcc'
      }
    }
  }

  ruby::version { '1.8.7-p357':
    env => $env
  }
}
