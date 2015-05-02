#!/usr/bin/env perl6

use v6;

use Test;
use PriorityQueue;

plan 2;

{
    my @numbers  = 55, 93, 79, 79, 71, 1, 26, 12, 67, 53; # just some random numbers
    my @sorted   = @numbers.sort;
    my @enqueued = do gather {
        my $q = PriorityQueue.new;
        $q.push: $_ for @numbers;
        while $q.shift -> $n {
            take $n;
        }
    };

    is_deeply @enqueued, @sorted;
}

{
    my @numbers = 31, 2, 84, 45, 73, 64, 50, 64, 39, 30;
    my @sorted   = @numbers.sort.reverse;
    my @enqueued = do gather {
        my $q = PriorityQueue.new(:cmp(&[after]));
        $q.push: $_ for @numbers;
        while $q.shift -> $n {
            take $n;
        }
    };

    is_deeply @enqueued, @sorted;
}
