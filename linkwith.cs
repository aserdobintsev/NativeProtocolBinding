using System;
using ObjCRuntime;

[assembly: LinkWith ("libNativeProtocolUniversal.a", LinkTarget.ArmV7 | LinkTarget.Simulator | LinkTarget.Simulator64 | LinkTarget.Arm64, ForceLoad = true)]
