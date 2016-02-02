#import "Problem.h"

@implementation Problem

-(id) initWithdisplacement:(double)displacement andAcceleration:(double)acceleration andInitialVelocity:(double)vi andFinalVelocity:(double)vf andTime:(double)time
{
    self = [super init];
    
    if (self)
    {
        self.displacement = displacement;
        self.initialVelocity = vi;
        self.finalVelocity = vf;
        self.time = time;
        self.acceleration = acceleration;
    }
    
    return self;
}

- (void)clear
{
    self.displacement = NAN;
    self.initialVelocity = NAN;
    self.finalVelocity = NAN;
    self.time = NAN;
    self.acceleration = NAN;
}

//equations
-(void)solve
{
    if (isnan(self.finalVelocity))
        [self withoutFinalVelocity];
    
    else if (isnan(self.displacement))
        [self withoutDisplacement];
    
    else if (isnan(self.acceleration))
        [self withoutAcceleration];
    
    else if (isnan(self.time))
        [self withoutTime];
    
    
    for (int i = 0; i < 2; i++)
    {
        [self withoutAcceleration];
        [self withoutDisplacement];
        [self withoutFinalVelocity];
        [self withoutTime];
    }
}

-(void)withoutFinalVelocity
{
    // d = vi * t + .5at^2
    
    if (!isnan(self.initialVelocity) && !isnan(self.time) && !isnan(self.acceleration) ) //displacement
        self.displacement = self.initialVelocity * self.time + .5 * self.acceleration * self.time * self.time;
    
    else if (isnan(self.initialVelocity)) //displacement, time, acceleration
    {
        double part1 = .5 * self.acceleration * self.time * self.time;
        double part2 = self.displacement - part1;
        part2 /= self.time;
        
        self.initialVelocity = part2; //initial velocity
    }
    
    
    else if (isnan(self.acceleration)) //displacement, initial velocity, time
    {
        double part1 = self.initialVelocity * self.time;
        double part2 = self.displacement - part1;
        part2 = part2 * 2 / self.time / self.time;
        
        self.acceleration = part2; //acceleration
    }
}

-(void)withoutTime
{
    //vf^2 = vi^2 + 2ad
    
    double finalVelocitySquared = self.finalVelocity * self.finalVelocity;
    double initialVelocitySquared = self.initialVelocity * self.initialVelocity;
    
    if (!isnan(self.initialVelocity) && !isnan(self.acceleration) && !isnan(self.displacement)) //final velocity
        self.finalVelocity = sqrt(initialVelocitySquared + 2 * self.acceleration * self.displacement);
    
    else if (isnan(self.initialVelocity)) //acceleration, displacement, final velocity
    {
        double part1 = 2 * self.acceleration * self.displacement;
        double part2 = sqrt(finalVelocitySquared - part1);
        
        self.initialVelocity = part2; //initial velocity
    }
    
    else if (isnan(self.acceleration)) //final velocity, initial velocity, displacement
    {
        double part1 = finalVelocitySquared - initialVelocitySquared;
        double part2 = part1 / 2 / self.displacement;
        
        self.acceleration = part2; //acceleration
    }
    
    else if (isnan(self.displacement)) //final velocity, initial velocity, acceleration
    {
        double part1 = finalVelocitySquared - initialVelocitySquared;
        double part2 = part1 / 2 / self.acceleration;
        
        self.displacement = part2; //displacement
    }
}

-(void)withoutDisplacement
{
    //vf = vi + at
    if (!isnan(self.initialVelocity) && !isnan(self.acceleration) && !isnan(self.time) )
        self.finalVelocity = self.initialVelocity + self.acceleration * self.time;
    
    else if (isnan(self.initialVelocity))
    {
        double part1 = self.acceleration * self.time;
        double part2 = self.finalVelocity - part1;
        
        self.initialVelocity = part2;
    }
    
    else if (isnan(self.acceleration))
    {
        double part1 = self.finalVelocity - self.initialVelocity;
        part1 /= self.time;
        
        self.acceleration = part1;
    }
    
    else if (isnan(self.time))
    {
        double part1 = self.finalVelocity - self.initialVelocity;
        part1 /= self.acceleration;
        
        self.time = part1;
    }
}

-(void)withoutAcceleration
{
    if (!isnan(self.initialVelocity) && !isnan(self.finalVelocity) && !isnan(self.time) )
        self.displacement = (self.initialVelocity + self.finalVelocity) / 2 * self.time;
    
    else if (isnan(self.initialVelocity)) //displacement, time, final velocity
    {
        double part1 = self.displacement * 2 / self.time;
        double part2 = part1 - self.finalVelocity;
        
        self.initialVelocity = part2; //initial velocity
    }
    
    else if (isnan(self.finalVelocity)) //displacement, initial velocity, time
    {
        double part1 = self.displacement * 2 / self.time;
        double part2 = part1 - self.initialVelocity;
        
        self.finalVelocity = part2; //final velocity
    }
    
    else if (isnan(self.time)) //displacement, final velocity, time
    {
        double part1 = self.displacement * 2;
        double part2 = self.initialVelocity + self.finalVelocity;
        part1 /= part2;
        
        self.time = part1; //time
    }
}

-(void)printSolution
{
    NSLog(@"%@", self);
}

-(NSString *)description
{
    double tempTime = self.time;
    if (tempTime < 0)
        tempTime = -tempTime;
    
    NSString *variables = [NSString stringWithFormat: @"\ndisplacement: %f\n"
                           "Acceleration: %f\n"
                           "Initial Velocity: %f\n"
                           "Final Velocity: %f\n"
                           "Time: %f\n\n"
                           , self.displacement, self.acceleration, self.initialVelocity, self.finalVelocity, tempTime];
    return variables;
}

@end
