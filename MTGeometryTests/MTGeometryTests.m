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
    XCTAssertTrue(delta.x == 3);
    XCTAssertTrue(delta.y == -4);
}

- (void)testPointDistance
{
	XCTAssertTrue(CGPointDistance(CGPointMake(0, 0), CGPointMake(0, 5)) == 5.0);
	XCTAssertTrue((float)CGPointDistance(CGPointMake(1, 1), CGPointMake(2, 2)) == (float)sqrt(2));
}

- (void)testPointAlongLine
{
    CGLine line = CGLineMake(CGPointMake(0, 0), CGPointMake(1, 1));
    CGFloat distance = 1.0;
    CGPoint point = CGPointAlongLine(line, distance);
    XCTAssertTrue(CGPointEqualToPoint(point, CGPointMake(1.0 / sqrt(2.0), 1.0 / sqrt(2.0))));
}

- (void)testPointRotatedAroundPoint
{
    CGPoint original    = CGPointMake(2, 2);
    CGPoint pivot       = CGPointMake(1, 1);
    CGFloat degrees     = 90;
    CGPoint rotated     = CGPointRotatedAroundPoint(original, pivot, degrees);
    XCTAssertEqualWithAccuracy(rotated.x, 0, 0.00001);
    XCTAssertEqualWithAccuracy(rotated.y, 2, 0.00001);
}




#pragma mark - Lines

- (void)testLineMake
{
	CGLine line = CGLineMake(CGPointMake(1, 1), CGPointMake(3, 3));
	XCTAssertTrue(line.point1.x == 1);
	XCTAssertTrue(line.point1.y == 1);
	XCTAssertTrue(line.point2.x == 3);
	XCTAssertTrue(line.point2.y == 3);
}

- (void)testLineEqualToLine
{
	CGLine lineA = CGLineMake(CGPointMake(1, 1), CGPointMake(3, 3));
	CGLine lineB = CGLineMake(CGPointMake(1, 1), CGPointMake(3, 3));
	XCTAssertTrue(CGLineEqualToLine(lineA, lineB));
}

- (void)testLineMidPoint
{
	CGLine line = CGLineMake(CGPointMake(0, 0), CGPointMake(2, 4));
	XCTAssertTrue(CGPointEqualToPoint(CGLineMidPoint(line), CGPointMake(1,2)));
}

- (void)testLinesIntersectAtPoint
{
	CGLine line1 = CGLineMake(CGPointMake(2, 0), CGPointMake(2, 4));
	CGLine line2 = CGLineMake(CGPointMake(0, 2), CGPointMake(4, 2));
	XCTAssertTrue(CGPointEqualToPoint(CGLinesIntersectAtPoint(line1, line2), CGPointMake(2, 2)));

	line1 = CGLineMake(CGPointMake(5, 0), CGPointMake(5, 4));
	line2 = CGLineMake(CGPointMake(0, 1), CGPointMake(6, 4));
	XCTAssertTrue(CGPointEqualToPoint(CGLinesIntersectAtPoint(line1, line2), CGPointMake(5, 3.5)));
}

- (void)testLineLength
{
	CGLine line = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
	XCTAssertTrue((float)CGLineLength(line) == (float)sqrt(2));
}

- (void)testLineScale
{
	CGLine line = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
	XCTAssertTrue(CGLineEqualToLine(CGLineScale(line, 2), CGLineMake(CGPointMake(2, 2), CGPointMake(4, 4))));
}

- (void)testLineTranslate
{
    CGLine line         = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
    CGLine translated   = CGLineTranslate(line, CGDeltaMake(2, 2));
    CGLine expected     = CGLineMake(CGPointMake(4, 4), CGPointMake(5, 5));
	XCTAssertTrue(CGLineEqualToLine(translated, expected));
}

- (void)testLineScaleOnMidPoint
{
    CGLine line     = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
    CGLine scaled   = CGLineScaleOnMidPoint(line, 2);
    CGLine expected = CGLineMake(CGPointMake(1.5, 1.5), CGPointMake(3.5, 3.5));
    XCTAssertEqualWithAccuracy(scaled.point1.x, expected.point1.x, 0.0001);
    XCTAssertEqualWithAccuracy(scaled.point1.y, expected.point1.y, 0.0001);
    XCTAssertEqualWithAccuracy(scaled.point2.x, expected.point2.x, 0.0001);
    XCTAssertEqualWithAccuracy(scaled.point2.y, expected.point2.y, 0.0001);
}

- (void)testLineDelta
{
	CGLine line = CGLineMake(CGPointMake(2, 2), CGPointMake(3, 3));
	XCTAssertTrue(CGLineDelta(line).x == 1 && CGLineDelta(line).y == 1);
}

- (void)testParallelLines
{
	CGLine line1 = CGLineMake(CGPointMake(2, 5), CGPointMake(5, 8));
	CGLine line2 = CGLineMake(CGPointMake(2, 2), CGPointMake(5, 5));
	XCTAssertTrue(CGLinesAreParallel(line1, line2));
    
	line1 = CGLineMake(CGPointMake(2, 6), CGPointMake(5, 8));
	line2 = CGLineMake(CGPointMake(2, 2), CGPointMake(5, 5));
	XCTAssertFalse(CGLinesAreParallel(line1, line2));
}


#pragma mark - Rectangles

- (void)testRectTopLeftPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	XCTAssertTrue(CGPointEqualToPoint(CGRectTopLeftPoint(rect), CGPointMake(1, 1)));
}

- (void)testRectTopRightPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	XCTAssertTrue(CGPointEqualToPoint(CGRectTopRightPoint(rect), CGPointMake(5, 1)));
}

- (void)testRectBottomLeftPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	XCTAssertTrue(CGPointEqualToPoint(CGRectBottomLeftPoint(rect), CGPointMake(1, 5)));
}

- (void)testRectBottomRightPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	XCTAssertTrue(CGPointEqualToPoint(CGRectBottomRightPoint(rect), CGPointMake(5, 5)));
}

- (void)testRectResize
{
	CGRect rect = CGRectMake(3, 3, 2, 2);
	XCTAssertTrue(CGRectEqualToRect(CGRectResize(rect, CGSizeMake(4, 4)), CGRectInset(rect, -1, -1)) );
}

- (void)testRectInsetEdge
{
	CGRect rect = CGRectMake(3, 3, 2, 2);
	XCTAssertTrue(CGRectEqualToRect(CGRectInsetEdge(rect, CGRectMaxXEdge , -1), CGRectMake(3, 3, 1, 2)));
}

- (void)testRectStackedWithinRectFromEdge
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMinYEdge, NO), CGRectMake(2, 1, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinYEdge, NO), CGRectMake(1, 2, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinYEdge, YES), CGRectMake(4, 2, 1, 1)));
	
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMinXEdge, NO), CGRectMake(1, 3, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinXEdge, NO), CGRectMake(2, 4, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMinXEdge, YES), CGRectMake(2, 1, 1, 1)));

	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMaxYEdge, NO), CGRectMake(3, 4, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxYEdge, NO), CGRectMake(4, 3, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxYEdge, YES), CGRectMake(1, 3, 1, 1)));

	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 2, CGRectMaxXEdge, NO), CGRectMake(4, 2, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxXEdge, NO), CGRectMake(3, 1, 1, 1)));
	XCTAssertTrue(CGRectEqualToRect(CGRectStackedWithinRectFromEdge(rect, CGSizeMake(1, 1), 5, CGRectMaxXEdge, YES), CGRectMake(3, 4, 1, 1)));
}

- (void)testRectCenterPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);
	XCTAssertTrue(CGPointEqualToPoint(CGRectCenterPoint(rect), CGPointMake(3, 3)));
}

- (void)testRectClosestTwoCornerPoints
{
	CGRect rect = CGRectMake(2, 1, 4, 4);

	CGPoint point = CGPointMake(0, 0);
	CGPoint point1 = CGPointZero;
	CGPoint point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 1)) || CGPointEqualToPoint(point2, CGPointMake(2, 1)));
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 5)) || CGPointEqualToPoint(point2, CGPointMake(2, 5)));

	point = CGPointMake(7, 3);
	point1 = CGPointZero;
	point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 1)) || CGPointEqualToPoint(point2, CGPointMake(6, 1)));
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 5)) || CGPointEqualToPoint(point2, CGPointMake(6, 5)));

	point = CGPointMake(3, 6);
	point1 = CGPointZero;
	point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 5)) || CGPointEqualToPoint(point2, CGPointMake(2, 5)));
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 5)) || CGPointEqualToPoint(point2, CGPointMake(6, 5)));

	point = CGPointMake(4, 2);
	point1 = CGPointZero;
	point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(2, 1)) || CGPointEqualToPoint(point2, CGPointMake(2, 1)));
	XCTAssertTrue(CGPointEqualToPoint(point1, CGPointMake(6, 1)) || CGPointEqualToPoint(point2, CGPointMake(6, 1)));
}

- (void)testLineIntersectsRectAtPoint
{
	CGRect rect = CGRectMake(1, 1, 4, 4);

	CGLine line = CGLineMake(CGPointMake(0, 1), CGPointMake(2, 2));
	XCTAssertTrue(CGPointEqualToPoint(CGLineIntersectsRectAtPoint(rect, line), CGPointMake(5, 3.5)));
}



@end
