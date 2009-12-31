def cleanup_report(file_name)
  if File.exists? file_name
    File.delete file_name
  end
end

spec_dir = File.dirname(ARGV[0])
rails_project_dir = "#{spec_dir}/../.."

report_file = "/tmp/vim_rspec_report.html"

rspec_rails_plugin = File.join(rails_project_dir,'vendor','plugins','rspec','lib')
if File.directory?(rspec_rails_plugin)
  $LOAD_PATH.unshift(rspec_rails_plugin)
end
require 'rubygems'
require 'spec'
require 'spec/runner/formatter/html_formatter'

module Spec
  module Runner
    module Formatter
      class HtmlFormatter
        def backtrace_line(line)
          line.gsub(/([^:]*\.rb):(\d*)/) do
            "<a href=\"vim://#{File.expand_path($1)}?#{$2}\">#{$1}:#{$2}</a> "
          end
        end
      end
    end
  end
end

cleanup_report(report_file)

argv = [ARGV[0]]
argv << "--c"
argv << "--format"
argv << "html:#{report_file}"

::Spec::Runner::CommandLine.run(::Spec::Runner::OptionParser.parse(argv, STDERR, STDOUT))

if File.exists? report_file
  `open #{report_file}`
end
