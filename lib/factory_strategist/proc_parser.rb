# frozen_string_literal: true

# module to get parsed proc as string
# the codes in this file are based on https://secret-garden.hatenablog.com/entry/2019/09/08/145037 by @osyo-manga
module ProcParser
  ELEMENTS = %i[
    magic
    major_version
    minor_version
    format_type
    misc
    label
    path
    absolute_path
    first_lineno
    type
    locals
    args
    catch_table
    bytecode
  ].freeze

  refine RubyVM::InstructionSequence do
    def to_h
      ELEMENTS.zip(to_a).to_h
    end
  end

  using self

  refine Proc do
    def body # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      path, (start_lnum, start_col, end_lnum, end_col) = code_location

      raise "Unsupported file" if path.nil?

      File.readlines(path).then do |lines|
        start_line = lines[start_lnum - 1]
        end_line = lines[end_lnum - 1]
        if start_lnum == end_lnum
          start_line[(start_col + 1)...(end_col - 1)]
        elsif end_lnum - start_lnum == 1
          start_line[(start_col + 1)...] + end_line[...(end_col - 1)]
        else
          lines[start_lnum...(end_lnum - 1)].join
        end
      end
    end

    def code_location
      RubyVM::InstructionSequence.of(self).to_h
                                 .then { |iseq| [iseq[:absolute_path], iseq.dig(:misc, :code_location)] }
    end
  end
end
