module Polylabel
  class Cell
    attr_reader :x, :y, :h, :d, :max

    def initialize(x, y, h, polygon)
      @x = x
      @y = y
      @h = h
      @d = point_to_polygon_dist(x, y, polygon)
      @max = @d + @h * Math.sqrt(2)
    end

    private

    def point_to_polygon_dist(x, y, polygon)
      inside = false
      min_dist_sq = Float::INFINITY

      polygon.each do |ring|
        b = ring[-1]
        ring.each do |a|
          if (a[1] > y) != (b[1] > y) && (x < (b[0] - a[0]) * (y - a[1]) / (b[1] - a[1]) + a[0])
            inside = !inside
          end
          min_dist_sq = [min_dist_sq, get_seg_dist_sq(x, y, a, b)].min
          b = a
        end
      end

      if min_dist_sq.zero?
        0
      else
        result = Math.sqrt(min_dist_sq)
        if inside
          result
        else
          result * -1
        end
      end
    end

    def get_seg_dist_sq(px, py, a, b)
      x = a[0]
      y = a[1]
      dx = b[0] - x
      dy = b[1] - y

      if dx != 0 || dy != 0
        t = ((px - x) * dx + (py - y) * dy) / (dx * dx + dy * dy)

        if t > 1
          x = b[0]
          y = b[1]
        elsif t.positive?
          x += dx * t
          y += dy * t
        end
      end

      dx = px - x
      dy = py - y

      dx * dx + dy * dy
    end
  end
end
