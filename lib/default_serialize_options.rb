# Copyright (c) 2009 James Smith (jlsmith@gmail.com)
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module DefaultSerializeOptions
  def self.included(base)
    base.send :extend, ClassMethods
  end
end

module ClassMethods
  def default_serialize_options options = {}
    cattr_accessor :to_xml_opts, :to_json_opts
    opts = (has_serialize_options_key?(options)) ? options : {:all => options}
    self.to_json_opts = opts[:json] || opts[:all]
    self.to_xml_opts  = opts[:xml]  || opts[:all]
    send :include, InstanceMethods
  end
  def has_serialize_options_key? options 
    (options.has_key?(:json) || options.has_key?(:xml) || options.has_key?(:all))
  end
end

module InstanceMethods
  def serialize_options type, options
    default_opts = (type == :xml) ? self.class.to_xml_opts : self.class.to_json_opts
    (options[:ignore_defaults] || default_opts.nil?) ? options : default_opts.dup.update(options)
  end
    
  def to_xml options = {}
    super serialize_options(:xml, options)
  end
  
  def to_json options = {}
    super serialize_options(:json, options)
  end
  
end
