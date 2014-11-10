// example.i
%module example
%{
#include "example.h"
%}

// -------------------------- get_service ------------------------------------

// Define your typemaps before includeing the required methods.
// That way swig will know what to do with the methods when it actually encounters them.
%typemap(out) MYService *
{
    $result = SWIG_FromCharPtr("Test String"); argvi++ ;
    free($1);
}

// -------------------------- get_service_array -----------------------------
%typemap(out) MYService **
{
    AV* arr = newAV();
    int index = 0;
    while($1[index] != NULL)
    {
        MYService *service = $1[index++];
        av_push(arr, SWIG_FromCharPtr(service->stringEntry));
        free(service);
    }
    // We need a mortal reference value. i.e. the ownership of this array
    // is passed to the perl stack.
    $result = newRV(sv_2mortal((SV *)arr)); argvi++;
    free($1);
}

// -------------------------- fillup_service --------------------------------

// The next two methods are for fillup_service
%typemap(argout) MYService **servicePointer
{
    // Convert the return value of fillup_service to integer again
    // Using ST(0) instead of ($)result since the argvi would have already been incremented
    // after the fillup_service call.
    // Using SWIG's own api to convert value to integer.
    int retValue = -1;
    int errorCodeVal = SWIG_AsVal_int SWIG_PERL_CALL_ARGS_2(ST(0), &retValue);
    if(retValue == 0)
    {
        // ($)result gets expanded to ST(argvi). And since the first call to method fillup_service
        // would have incremented argvi, we need to decrement it again to fetch set result correctly.
        argvi--;
        MYService *service = (MYService *)temp$argnum;
        $result = SWIG_FromCharPtr(service->stringEntry);
        // Once our work is done, we have to increment argvi again.
        argvi++;
        free(temp$argnum);
    }
    else
    {
        // Don't try freeing $result!! Leads to seg fault.
        // free($result);
        // TODO: Throw error here
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
    int retValue = -1;
    // Using ST(0) instead of ($)result since the argvi is already incremented.
    int errorCodeVal = SWIG_AsVal_int SWIG_PERL_CALL_ARGS_2(ST(0), &retValue);
    if(retValue == 0)
    {
        AV* arr = newAV();
        int index = 0;
        while(temp$argnum[index] != NULL)
        {
            MYService *service = temp$argnum[index++];
            av_push(arr, SWIG_FromCharPtr(service->stringEntry));
            free(service);
        }
        free(temp$argnum);
        // We need a mortal reference value. i.e. the ownership of this array
        // is passed to the perl stack.
        argvi--;
        $result = newRV(sv_2mortal((SV *)arr));
        argvi++;
    }
    else
    {
        // Don't try freeing $result!! Leads to seg fault.
        // free($result);
        // TODO: Throw error here
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
