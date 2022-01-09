# frozen_string_literal: true

require_relative "polylabel/version"
require_relative "polylabel/cell"
require "pqueue"

module Polylabel
  def self.compute(polygon, precision = 1.0)
    # find the bounding box of the outer ring
    first_item = polygon[0][0]

    min_x = first_item[0]
    min_y = first_item[1]
    max_x = first_item[0]
    max_y = first_item[1]

    polygon[0].each do |p|
      min_x = p[0] if p[0] < min_x
      min_y = p[1] if p[1] < min_y
      max_x = p[0] if p[0] > max_x
      max_y = p[1] if p[1] > max_y
    end

    width = max_x - min_x
    height = max_y - min_y
    cell_size = [width, height].min
    h = cell_size / 2.0

    return { x: min_x, y: min_y, distance: 0 } if cell_size.zero?

    # a priority queue of cells in order of their "potential" (max distance to polygon)
    cell_queue = PQueue.new { |a, b| a.max > b.max }

    # cover polygon with initial cells
    x = min_x
    while x < max_x
      y = min_y
      while y < max_y
        cell_queue.push Cell.new(x + h, y + h, h, polygon)
        y += cell_size
      end
      x += cell_size
    end

    # take centroid as the first best guess
    best_cell = get_centroid_cell(polygon)

    #  second guess: bounding box centroid
    bbox_cell = Cell.new(min_x + width / 2, min_y + height / 2, 0, polygon)

    best_cell = bbox_cell if bbox_cell.d > best_cell.d

    num_probes = cell_queue.length

    until cell_queue.empty?
      #  pick the most promising cell from the queue
      cell = cell_queue.pop

      #  update the best cell if we found a better one
      best_cell = cell if cell.d > best_cell.d

      # do not drill down further if there's no chance of a better solution
      next if cell.max - best_cell.d <= precision

      # split the cell into four cells
      h = cell.h / 2
      cell_queue.push(Cell.new(cell.x - h, cell.y - h, h, polygon))
      cell_queue.push(Cell.new(cell.x + h, cell.y - h, h, polygon))
      cell_queue.push(Cell.new(cell.x - h, cell.y + h, h, polygon))
      cell_queue.push(Cell.new(cell.x + h, cell.y + h, h, polygon))
      num_probes += 4
    end

    {
      x: best_cell.x,
      y: best_cell.y,
      distance: best_cell.d
    }
  end

  def self.get_centroid_cell(polygon)
    area = 0
    x = 0
    y = 0
    points = polygon[0]

    b = points[-1]
    points.each do |a|
      f = a[0] * b[1] - b[0] * a[1]
      x += (a[0] + b[0]) * f
      y += (a[1] + b[1]) * f
      area += f * 3
      b = a
    end

    if area.zero?
      Cell.new(points[0][0], points[0][1], 0, polygon)
    else
      Cell.new(x / area, y / area, 0, polygon)
    end
  end
end
