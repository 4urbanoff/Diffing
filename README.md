# Diffing

## Installation

```
sudo gem install differ
```

## Usage

```ruby
require 'diffing'

from = "Hello! I am string for diffing test"
to   = "Hi! I am two string for diffing"
```

#### By chars
```ruby
diff = Diffing.by_chars( from, to )

diff.as_ascii
# => H{"ello" >> "i"}! I am{+" two"} string for diffing{-" test"}
diff.as_html
# => H<del>ello</del><ins>i</ins>! I am<ins> two</ins> string for diffing<del> test</del>
```

#### By words
```ruby
diff = Diffing.by_words( from, to )

diff.as_ascii
# => {"Hello!" >> "Hi!"} I am {+"two"} string for diffing {-"test"}
diff.as_html
# => <del>Hello!</del><ins>Hi!</ins> I am <ins>two</ins> string for diffing <del>test</del>
```

#### By lines
```ruby
diff = Diffing.by_lines( from, to )

diff.as_ascii
# => {"Hello! I am string for diffing test" >> "Hi! I am two string for diffing"}
diff.as_html
# => <del>Hello! I am string for diffing test</del><ins>Hi! I am two string for diffing</ins>
```

## Custom format

```ruby
module CustomFormat
  class << self

    def source( value )
      value
    end

    def insert( value )
      "(++#{ value })"
    end

    def delete( value )
      "(--#{ value })"
    end

    def replace( from, to )
      "(#{ from } => #{ to })"
    end

  end
end


Diffing.by_chars.format( CustomFormat )
# => H(ello => i)! I am(++ two) string for diffing(-- test)
Diffing.by_words.format( CustomFormat )
# => (Hello! => Hi!) I am (++two) string for diffing (--test)
Diffing.by_lines.format( CustomFormat )
# => (Hello! I am string for diffing test => Hi! I am two string for diffing)

```

## Custom delimiter

```ruby
Diffing::Diff.new( from, to, 'i' ).as_ascii
# => {"Hello! I am str" >> "Hi! I am two str"}ing for diffi{"ng test" >> "ng"}
```

## Custom use separated parts

```ruby
Diffing.by_words( from, to ).parts.map { |part|
  
  result = ''
  result << "<source:#{ part.source }>" if part.source?
  result << "<insert:#{ part.insert }>" if part.insert?
  result << "<delete:#{ part.delete }>" if part.delete?
  result
  
}.join( '' )
# => <insert:Hi!><delete:Hello!><source:I am><insert:two><source:string for diffing><delete:test>
```

## Copyright

Copyright © 2015 Denis Churbanov