desc "Sync github.com:Paxa/libxlsxwriter to ./libxlsxwriter"
task :sync do
  require 'fileutils'
  FileUtils.rm_rf("./libxlsxwriter")
  system("git clone --depth 10 git@github.com:Paxa/libxlsxwriter.git")
  Dir.chdir("./libxlsxwriter") do
    system("git show --pretty='format:%cd %h' --date=iso --quiet > version.txt")
    FileUtils.rm_rf("./.git")
  end
end

desc "Regenerate FFI bindings"
task :generate_ffi do
  require 'ffi_gen'

  output_file = 'lib/fast_excel/binding.rb'
  replacement = <<-EOT
  LIB_FILENAME = if RUBY_PLATFORM =~ /darwin/
    "libxlsxwriter.dylib"
  else
    "libxlsxwriter.so"
  end

  ffi_lib File.expand_path("./../../../libxlsxwriter/lib/\#{LIB_FILENAME}", __FILE__)
  EOT

  FFIGen.generate(
    module_name: 'Libxlsxwriter',
    ffi_lib:     'replaceme',
    headers:     %w(
      libxlsxwriter/include/xlsxwriter/workbook.h
      libxlsxwriter/include/xlsxwriter/theme.h
      libxlsxwriter/include/xlsxwriter/custom.h
      libxlsxwriter/include/xlsxwriter/core.h
      libxlsxwriter/include/xlsxwriter/drawing.h
      libxlsxwriter/include/xlsxwriter/worksheet.h
      libxlsxwriter/include/xlsxwriter/chart.h
      libxlsxwriter/include/xlsxwriter/content_types.h
      libxlsxwriter/include/xlsxwriter/app.h
      libxlsxwriter/include/xlsxwriter/relationships.h
      libxlsxwriter/include/xlsxwriter/styles.h
      libxlsxwriter/include/xlsxwriter/hash_table.h
      libxlsxwriter/include/xlsxwriter/packager.h
      libxlsxwriter/include/xlsxwriter/shared_strings.h
      libxlsxwriter/include/xlsxwriter/format.h
      libxlsxwriter/include/xlsxwriter/xmlwriter.h
      libxlsxwriter/include/xlsxwriter.h
    ),
    # Other libxlsxwriter headers, ignored because they produce invalid bindings
    #
    # libxlsxwriter/include/xlsxwriter/utility.h
    # libxlsxwriter/include/xlsxwriter/common.h
    #
    # Third party headers, probably not usefull in the bindings, and produce errors
    #
    # libxlsxwriter/include/xlsxwriter/third_party/tree.h
    # libxlsxwriter/include/xlsxwriter/third_party/zip.h
    # libxlsxwriter/include/xlsxwriter/third_party/tmpfileplus.h
    # libxlsxwriter/include/xlsxwriter/third_party/ioapi.h
    # libxlsxwriter/include/xlsxwriter/third_party/queue.h
    prefixes:    ["LXW", 'Lxw', 'lxw'],
    output:      output_file
  )

  IO.write(output_file, File.open(output_file) do |f|
      f.read.gsub(/^\s*ffi_lib "replaceme"\s*$/, "\n#{replacement}")
    end
  )
end

require 'rake/testtask'

Rake::TestTask.new do |test|
  test.test_files = Dir.glob('test/**/*_test.rb')
end

#task :default => :test

task :examples do
  Dir.glob('examples/**/*.rb').each do |file|
    require './' + file.sub(/\.rb$/, '')
  end
end
