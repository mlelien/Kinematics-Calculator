#import <Foundation/Foundation.h>

@interface Problem : NSObject
@property (nonatomic) double displacement, initialVelocity, finalVelocity, time, acceleration;

-(id) initWithdisplacement:(double)displacement andAcceleration:(double)acceleration andInitialVelocity:(double)vi andFinalVelocity:(double)vf andTime:(double)time;
-(void)solve;
-(void)withoutFinalVelocity;
-(void)withoutTime;
-(void)withoutDisplacement;
-(void)printSolution;
-(void)clear;

@end
