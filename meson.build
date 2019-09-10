project(
  'blaze',
  'vala',
  'c'
)

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk+-3.0'),
  meson.get_compiler('c').find_library('m', required: false)
]

sources = files(
  'src/Main.vala',

  'src/Application.vala',
  'src/Window.vala',
  'src/Timeline.vala',

  'src/Util.vala',
)

executable(
  'blaze',
  sources,
  dependencies: dependencies
)
