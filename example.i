// example.i
%module _example
%{
#include "example.h"
%}

// -------------------------- get_service ------------------------------------

// Define your typemaps before includeing the required methods.
// That way swig will know what to do with the methods when it actually encounters them.
%typemap(out) MYService *
{
    // '$1' points to output value of the function i.e. MyService entry returned from the function.
    $result = SWIG_FromCharPtr($1->stringEntry); argvi++ ;
    free($1);
}

%typemap(out) MYService **
{
    if($1 != NULL)
    {
        AV* arr = newAV();
        int index = 0;
        while($1[index] != NULL)
        {
            MYService *service = $1[index++];
            // It is important that the string is NOT converted into a mortal value.
            // as the av_push anyways steals the reference.
            av_push(arr, newSVpv(service->stringEntry, strlen(service->stringEntry)));
            free(service);
        }
        // We need a mortal reference value. i.e. the ownership of this array
        // is passed to the perl stack.
        $result = newRV(sv_2mortal((SV *)arr)); argvi++;
        free($1);
    }
    else
    {
        // Note that there is no need to increment argvi here.
        $result = &PL_sv_undef;
    }
}

// -------------------------- fillup_service --------------------------------

// The next two methods are for fillup_service
%typemap(argout) MYService **servicePointer
{
    // Convert the return value of fillup_service to integer again
    // Using ST(0) instead of ($)result since the argvi would have already been incremented
    // after the fillup_service call.
    // Convert the value to integer again.
    // Using ST(0) instead of ($)result since the argvi is already incremented.
    int retValue = (int)SvNV(ST(0));
    if(retValue == 0)
    {
        // ($)result gets expanded to ST(argvi). And since the first call to method fillup_service
        // would have incremented argvi, we need to set it again and then increment to set results
        // correctly to stack.
        MYService *service = (MYService *)temp$argnum;
        ST(argvi) = SWIG_FromCharPtr(service->stringEntry);
        argvi++;
        free(temp$argnum);
    }
    else
    {
        // Don't try freeing $result!! Leads to seg fault.
        // free($result);
        // Set undef as the return value.
        ST(argvi) = &PL_sv_undef;
        argvi++;
    }
}

// The purpose of this method is to wrap last argument of 
// fillup_service by pasing a null 'MYService *' for any method
// that ends with MYService **;
%typemap (in,numinputs=0) MYService ** (MYService *temp) {
    $1 = &temp;
}

// -------------------------- fillup_service_array --------------------------

// The next two methods are for fillup_service_array
%typemap(argout) MYService ***serviceArrayPointer
{
    // Convert the value to integer again.
    // Using ST(0) instead of ($)result since the argvi is already incremented.
    int retValue = (int)SvNV(ST(0));
    if(retValue == 0)
    {
        AV* arr = newAV();
        int index = 0;
        while(temp$argnum[index] != NULL)
        {
            MYService *service = temp$argnum[index++];
            // It is important that the string is NOT converted into a mortal value.
            // as the av_push anyways steals the reference.
            av_push(arr, newSVpv(service->stringEntry, strlen(service->stringEntry)));
            free(service);
        }
        // We need a mortal reference value. i.e. the ownership of this array
        // is passed to the perl stack.
        ST(argvi) = newRV(sv_2mortal((SV *)arr));
        argvi++;
        // free($1);
    }
    else
    {
        // Don't try freeing $result!! Leads to seg fault.
        // free($result);

        // Set undef as next entry in stack
        ST(argvi) = &PL_sv_undef;
        argvi++;
    }
}

// The purpose of this method is to wrap last argument of 
// fillup_service_array by pasing a null 'MYService **' for any method
// that ends with MYService ***;
%typemap (in,numinputs=0) MYService *** (MYService **temp) {
  $1 = &temp;
}

// ----------------------------------------------------------------------------
%include "example.h"
