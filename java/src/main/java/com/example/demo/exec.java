package com.example.demo;

import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class exec implements Runnable {
    static Integer requestsHandled = 0;
    static List<Long> timeList = new ArrayList<>();

    @Override
    public void run() {
        int maxNum = 2147483647;
        int counter = 0;

        ZonedDateTime start = ZonedDateTime.now();
        System.out.println(counter);
        while (counter < maxNum) {
            counter += 1;
        }
        System.out.println("counter at end:");
        System.out.println(counter);

        ZonedDateTime end = ZonedDateTime.now();
        var diff = ChronoUnit.SECONDS.between(start, end);
        timeList.add(diff);
        requestsHandled += 1;
        System.out.println("Request #" + requestsHandled + " took" + diff + " seconds");
        Long total = 0L;
        for (Long long1 : timeList) {
            total += long1;
        }
        System.out.println("Total time: " + total );
    }

}
