use v6;

constant $VERSION = '0.01';

# XXX can I make this parameterized?
class PriorityQueue {
    has @!elements; # XXX should be @!elements{1..*}
    has &!cmp;

    # XXX unary cmp should compare by that function's results
    submethod BUILD(:&!cmp = &[before]) {
        # pad the array so that our starting index is
        # 1; makes our calculations a bit easier
        @!elements.push: Any;
    }

    method push($element) {
        @!elements.push: $element;

        my int $index = @!elements.end;

        while $index > 1 {
            my int $parent-index = $index div 2;
            my $parent           = @!elements[$parent-index];

            last unless &!cmp($element, $parent);

            @!elements[$index]        = $parent;
            @!elements[$parent-index] = $element;

            $index = $parent-index;
        }
    }

    method shift {
        return unless @!elements > 1;
        return @!elements.pop if @!elements == 2;

        my $result    = @!elements[1];
        @!elements[1] = @!elements.pop;

        my int $index   = 1;
        my int $end     = @!elements.end;
        my int $halfway = $end div 2;

        while $index <= $halfway {
            my $left-index  = $index * 2;
            my $right-index = $left-index + 1;

            my $swap-index = [$index, $left-index, $right-index].grep(* <= $end).min: {
                &!cmp(@!elements[$^a], @!elements[$^b]) ?? Order::Less !! Order::More
            };
            last if $index == $swap-index;

            @!elements[$index, $swap-index] = @!elements[$swap-index, $index];

            $index = $swap-index;
        }
        $result
    }
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
=end AUTHOR
