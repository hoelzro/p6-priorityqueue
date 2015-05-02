#!/usr/bin/env perl6

use v6;

use Test;
use PriorityQueue;

plan 1;

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
