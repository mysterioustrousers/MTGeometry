MTGeometry
==========

An extension to Core Graphics Geometry. Intersections, scaling, etc.

### Installation

In your Podfile, add this line:

    pod "MTGeometry"

pod? => https://github.com/CocoaPods/CocoaPods/

NOTE: You may need to add `-all_load` to "Other Linker Flags" in your targets build settings if the pods library only contains categories.

### Example Usage

Finding the point where two lines intersect:

	CGLine line1 = CGLineMake(CGPointMake(2, 0), CGPointMake(2, 4));
	CGLine line2 = CGLineMake(CGPointMake(0, 2), CGPointMake(4, 2));
	CGLinesIntersectAtPoint(line1, line2)	// => (2,2)

Find the closest two corner points of a rectangle to a point in space:

	CGRect rect = CGRectMake(2, 1, 4, 4);
	CGPoint point = CGPointMake(0, 0);
	CGPoint point1 = CGPointZero;
	CGPoint point2 = CGPointZero;
	CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);	// => (0,0) (2,1)

The point where a line intersects a rect, if at all:

	CGRect rect = CGRectMake(1, 1, 4, 4);
	CGLine line = CGLineMake(CGPointMake(0, 1), CGPointMake(2, 2));
	CGLineIntersectsRectAtPoint(rect, line);	// => (5, 3.5)

### Documentation

#### Points

Create a delta from x and y deltas

	CGDelta CGDeltaMake(CGFloat deltaX, CGFloat deltaY);

Get the distance between two points

	CGFloat	CGPointDistance(CGPoint p1, CGPoint p2);

A point along a line distance from point1.

	CGPoint CGPointAlongLine(CGLine line, CGFloat distance);

A point rotated around the pivot point by degrees.

	CGPoint CGPointRotatedAroundPoint(CGPoint point, CGPoint pivot, CGFloat degrees);

#### Lines

Create a line from 2 points.

	CGLine CGLineMake(CGPoint point1, CGPoint point2);

Returns true if two lines are exactly coincident

	bool CGLineEqualToLine(CGLine line1, CGLine line2);

Get a lines midpoint

	CGPoint CGLineMidPoint(CGLine line);

Get the point at which two lines intersect. Returns NOPOINT if they don't intersect.

	CGPoint CGLinesIntersectAtPoint(CGLine line1, CGLine line2);

Get the length of a line

	CGFloat CGLineLength(CGLine line);

Returns a scaled line. Point 1 acts as the base and Point 2 is extended.

	CGLine CGLineScale(CGLine line, CGFloat scale);

Returns the delta x and y of the line from point 1 to point 2.

	CGDelta CGLineDelta(CGLine line);

####Rectangles

Corners points of a CGRect

	CGPoint CGRectTopLeftPoint(CGRect rect);
	CGPoint CGRectTopRightPoint(CGRect rect);
	CGPoint CGRectBottomLeftPoint(CGRect rect);
	CGPoint CGRectBottomRightPoint(CGRect rect);

Returns a resized rect with the same centerpoint.

	CGRect	CGRectResize(CGRect rect, CGSize newSize);

Similar to CGRectInset but only insets one edge. All other edges do not move.

	CGRect	CGRectInsetEdge(CGRect rect, CGRectEdge edge, CGFloat amount);

Calculates the stacking of rectangles within a larger rectangle. The resulting rectangle is stacked counter clockwise along the edge specified. As soon as there are more rects than will fit, a new row is started, thus, they are stacked by column, then by row. `reverse` will cause them to be stacked counter-clockwise along the specified edge.

	CGRect	CGRectStackedWithinRectFromEdge(CGRect rect, CGSize size, int count, CGRectEdge edge, bool reverse);

Find the centerpoint of a rectangle.

	CGPoint CGRectCenterPoint(CGRect rect);

Assigns the closest two corner points to point1 and point2 of the rect to the passed in point.

	void	CGRectClosestTwoCornerPoints(CGRect rect, CGPoint point, CGPoint *point1, CGPoint *point2);

The point at which a line, extended infinitely past its second point, intersects the rectangle. Returns NOPOINT if no interseciton is found.

	CGPoint CGLineIntersectsRectAtPoint(CGRect rect, CGLine line);


