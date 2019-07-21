# bangilid

Find the steepest long path in a matrix of numerical data.

At some point I found this problem online and I wrote this because I was curious
if my solution to the problem was correct. It is functional but semi-incomplete
and not meant to be used for anything in particular :joy:

## Problem Statement

Given an NxN matrix of integers that describe the topography of an area, find
the longest path from a peak in the graph (high integer) to a trough
(low integer) by only traversing downwards (visiting a lower value integer) and
only in the four cardinal directions NSEW (up, down, right, left). Return the
result as an array of `[path_node_length, height]`.

Example, for the matrix:
```
[4, 8, 7, 3]
[2, 5, 9, 3]
[6, 3, 2, 5]
[4, 4, 1, 6]
```

The longest, steepest path is:
`9 -> 5 -> 3 -> 2 -> 1`

So the return value will be `[5, 8]`

## Complexity/Performance

This algorithm runs in O(n). The high-level process is as follows:

1. Visit each node in the matrix and partially construct an object containing
information about its neighbors.

2. Visit each node and link it to the nodes representing its neighbors, thus
creating a directed acyclic graph of the data.

3. Obtain a topographically sorted list of nodes from the dag.

4. Traverse these sorted nodes, calculating the steepest long path at each.

Given the file `spec/lib/full_dataset.txt`, it takes ~15 seconds to reach a result on_my_machine :tm:

## Usage

```ruby
map = Bangilid::MapMatrix.new.tap do |new_map|
  new_map.insert([4, 8, 7, 3])
  new_map.insert([2, 5, 9, 3])
  new_map.insert([6, 3, 2, 5])
  new_map.insert([4, 4, 1, 6])
end

Bangilid.solve_from_map(map)           # => [5, 8]
```

## License

(The MIT License), see `/LICENSE`
