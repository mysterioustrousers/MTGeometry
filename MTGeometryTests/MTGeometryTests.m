//
//  MTGeometryTests.m
//  MTGeometryTests
//
//  Created by Adam Kirk on 9/3/12.
//  Copyright (c) 2012 Mysterious Trousers. All rights reserved.
//

#import "MTGeometryTests.h"
#import "MTGeometry.h"

@implementation MTGeometryTests

- (void)setUp
{
    [super setUp];
}




#pragma mark - Points

- (void)testDeltaMake
{
    CGDelta delta = CGDeltaMake(3, -4);
    STAssertTrue(delta.x == 3, nil);
    STAssertTrue(delta.y == -4, nil);
}

- (void)testPointDistance
{
	STAssertTrue(CGPointDistance(CGPointMake(0, 0), CGPointMake(0, 5)) == 5.0, nil);
	STAssertTrue((float)CGPointDistance(CGPointMake(1, 1), CGPointMake(2, 2)) == (float)sqrt(2), nil);
}




#pragma mark - Lines

- (void)testLineMake
{
	CGLine line = CGLineMake(CGPointMake(1, 1), CGPointMake(3, 3));
	STAssertTrue(line.point1.x == 1, nil);
	STAssertTrue(line.point1.y == 1, nil);
	STAssertTrue(line.point2.x == 3, nil);
	STAssertTrue(line.point2.y == 3, nil);
}

- (void)testLineEqualToLine
{
	CGLine lineA = CGLineMake(CGPointMake(1, 1), CGPointMake(3, 3));
	CGLine lineB = CGLineMake(CGPointMake(1, 1), CGPointMake(3, 3));
	STAssertTrue(CGLineEqualToLine(lineA, lineB), nil);
}

- (void)testLineMidPoint
{
	CGLine line = CGLineMake(CGPointMake(0, 0), CGPointMake(2, 4));
	STAssertTrue(CGPointEqualToPoint(CGLineMidPoint(line), CGPointMake(1,2)), nil);
}

- (void)testLinesIntersectAtPoint
{
	CGLine line1 = CGLineMake(CGPointMake(2, 0), CGPointMake(2, 4));
	CGLine line2 = CGLineMake(CGPointMake(0, 2), CGPointMake(4, 2));
	STAssertTrue(CGPointEqualToPoint(CGLinesIntersectAtPoint(line1, line2), CGPointMake(2, 2)), nil);

	line1 = CGLineMake(CGPointMake(5, 0), CGPointMake(5, 4));
	line2 = CGLineMake(CGPointMake(0, 1), CGPointMake(6, 4));
	STAssertTrue(CGPointEqualToPoint(CGLinesIntersectAtPoint(line1, line2), CGPointMake(5, 3.5)), nil);
}

- (void)testLineLength
{
	CGLine line = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
	STAssertTrue((float)CGLineLength(line) == (float)sqrt(2), nil);
}

- (void)testLineScale
{
	CGLine line = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
	STAssertTrue(CGLineEqualToLine(CGLineScale(line, 2), CGLineMake(CGPointMake(2, 2), CGPointMake(4, 4))), nil);
}

- (void)testLineDelta
{
	CGLine line = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
	STAssertTrue(CGLineDelta(line).x == 1 && CGLineDelta(line).y == 1, nil);
}



#pragma mark - Rectangles

- (void)testRectTopLeftPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	STAssertTrue(CGPointEqualToPoint(CGRectTopLeftPoint(rect), CGPointMake(1, 1)), nil);
}

- (void)testRectTopRightPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	STAssertTrue(CGPointEqualToPoint(CGRectTopRightPoint(rect), CGPointMake(5, 1)), nil);
}

- (void)testRectBottomLeftPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	STAssertTrue(CGPointEqualToPoint(CGRectBottomLeftPoint(rect), CGPointMake(1, 5)), nil);
}

- (void)testRectBottomRightPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	STAssertTrue(CGPointEqualToPoint(CGRectBottomRightPoint(rect), CGPointMake(5, 5)), nil);
}

- (void)testRectResize
{
	CGRect rect = CGRectMake(3, 3, 2, 2);
	STAssertTrue(CGRectEqualToRect(CGRectResize(rect, CGSizeMake(4, 4)), CGRectInset(rect, -1, -1)) , nil);
}

- (void)testRectInsetEdge
{
	CGRect rect = CGRectMake(3, 3, 2, 2);
	STAssertTrue(CGRectEqualToRect(CGRectInsetEdge(rect, CGRectMaxXEdge , -1), CGRectMake(3, 3, 1, 2)), nil);
}

- (void)testRectStackedWithinRectFromEdge
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMinYEdge, NO), CGRectMake(2, 1, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinYEdge, NO), CGRectMake(1, 2, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinYEdge, YES), CGRectMake(4, 2, 1, 1)), nil);
	
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMinXEdge, NO), CGRectMake(1, 3, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinXEdge, NO), CGRectMake(2, 4, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinXEdge, YES), CGRectMake(2, 1, 1, 1)), nil);

	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMaxYEdge, NO), CGRectMake(3, 4, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxYEdge, NO), CGRectMake(4, 3, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxYEdge, YES), CGRectMake(1, 3, 1, 1)), nil);

	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMaxXEdge, NO), CGRectMake(4, 2, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxXEdge, NO), CGRectMake(3, 1, 1, 1)), nil);
	STAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxXEdge, YES), CGRectMake(3, 4, 1, 1)), nil);
}

- (void)testRectCenterPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	STAssertTrue(CGPointEqualToPoint(CGRectCenterPoint(rect), CGPointMake(3, 3)), nil);
}

- (void)testRectClosestTwoCornerPoints
{
	CGRect rect = CGRectMake(2, 1, 4, 4);

	CGPoint point = CGPointMake(0, 0);
	CGPoint point1 = CGPointZero;
	CGPoint point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 1)) || CGPointEqualToPoint(point2, CGPointMake(2, 1)), nil);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 5)) || CGPointEqualToPoint(point2, CGPointMake(2, 5)), nil);

	point = CGPointMake(7, 3);
	point1 = CGPointZero;
	point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 1)) || CGPointEqualToPoint(point2, CGPointMake(6, 1)), nil);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 5)) || CGPointEqualToPoint(point2, CGPointMake(6, 5)), nil);

	point = CGPointMake(3, 6);
	point1 = CGPointZero;
	point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 5)) || CGPointEqualToPoint(point2, CGPointMake(2, 5)), nil);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 5)) || CGPointEqualToPoint(point2, CGPointMake(6, 5)), nil);

	point = CGPointMake(4, 2);
	point1 = CGPointZero;
	point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 1)) || CGPointEqualToPoint(point2, CGPointMake(2, 1)), nil);
	STAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 1)) || CGPointEqualToPoint(point2, CGPointMake(6, 1)), nil);
}

- (void)testLineIntersectsRectAtPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);

	CGLine line = CGLineMake(CGPointMake(0, 1), CGPointMake(2, 2));
	STAssertTrue(CGPointEqualToPoint(CGLineIntersectsRectAtPoint(rect, line), CGPointMake(5, 3.5)), nil);
}



@end
