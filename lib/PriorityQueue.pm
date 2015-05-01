use v6;

constant $VERSION = '0.01';

class PriorityQueue {
}

=begin NAME
PriorityQueue
=end NAME

=begin VERSION
A<$VERSION>
=end VERSION

=begin SYNOPSIS
    use PriorityQueue;

    my $p = PriorityQueue.new;

    for 1 .. 100 {
        $p.push: 100.rand.floor;
    }

    # should return in increasing order
    while $p.shift -> $e {
        say $e;
    }

    # if you want a max heap, or just a different ordering:
    $p = PriorityQueue.new(:cmp(&infix:«>=»));
=end SYNOPSIS

=begin DESCRIPTION
This class implements a priority queue data structure.
=end DESCRIPTION

=begin AUTHOR
Rob Hoelz <rob AT-SIGN hoelz.ro>
=end
