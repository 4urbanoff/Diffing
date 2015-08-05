module Diffing

  class Diff


    attr_reader :parts

    def initialize( from, to, pattern = nil )
      @pattern = pattern
      @parts   = calcucate( split( from.to_s ), split( to.to_s ) ).flatten
    end

    def format( format )
      result = []
      @parts.each do |part|
        result << format.source(  part.source )              if part.source?
        result << format.insert(  part.insert )              if part.insert? && !part.delete?
        result << format.delete(  part.delete )              if part.delete? && !part.insert?
        result << format.replace( part.delete, part.insert ) if part.insert? && part.delete?
      end
      result.join
    end

    def as_ascii
      format Format::Ascii
    end

    def as_html
      format Format::Html
    end

    alias :to_s    :as_ascii
    alias :inspect :as_ascii


    private

    def calcucate( from, to )
      if found = find_middle( from, to )
        from_l, to_l, source, from_r, to_r = found
        [ calcucate( from_l, to_l ), Part.new( source: join( source ) ), calcucate( from_r, to_r ) ]
      else
        [ Part.new( insert: join( to ), delete: join( from ) ) ]
      end
    end

    def find_middle( from, to, min = 0, max = nil )

      return nil if from.empty? or to.empty?

      max  = from.size unless max
      size = min + ( ( max - min ) / 2.to_f ).round

      subsets_each( from, size ) do |subset, first, last|

        if found = find_middle_index( to, subset )

          return (
            size != min and find_middle( from, to, size, max ) or
            (
              from_l = from[ 0...first ]
              to_l   = to[ 0...found ]
              from_r = from[ last...from.size ]
              to_r   = to[ found + subset.size...to.size ]
              [ from_l, to_l, subset, from_r, to_r ]
            )
          )

        end

      end

      size != max and find_middle( from, to, min, size ) or nil

    end

    def find_middle_index( set, search_subset )
      return set.index( search_subset ) unless @pattern
      subsets_each( set, search_subset.size ){ |subset, first, last| return first if subset == search_subset }
      nil
    end

    def subsets_each( from, size )
      ( from.size - size + 1 ).times do |first|
        last     = first + size
        subset = from[ first...last ]
        yield subset, first, last
      end
    end

    def split( set )
      @pattern ? set.scan( @pattern ) : set
    end

    def join( set )
      @pattern ? set.join : set
    end

  end

end
