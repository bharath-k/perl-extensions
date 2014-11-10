/*
 * Author: Bharath Kumaran
 * Licensing: GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
 * Description: example header file.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "example.h"

MYService *
get_service()
{
    // Just malloc a MYService with dummy values.
    MYService *service = NULL;
    service = calloc(1, sizeof(MYService));
    char *strval = calloc(20, sizeof(char *));
    strcpy(strval, "test1 string");
    service->stringEntry = strval;
    return service;
}


char *get_string(int intVal)
{
    char *strval = calloc(20, sizeof(char *));
    strcpy(strval, "test1 string");
    return strval;
}

MYService **
get_service_array()
{
    // Just initialized a null array and fill up some dummy values.
    MYService **serviceArray = calloc(3, sizeof(MYService *));
    serviceArray[0] = get_service();
    serviceArray[1] = get_service();
    return serviceArray;
}

int
fillup_service(int fail, MYService **servicePointer)
{
    if(fail == 0)
    {
        *servicePointer = get_service();
        return 0;
    }
    else return 1;
}

int
fillup_service_array(int fail, MYService ***serviceArrayPointer)
{
    if(fail == 0)
    {
        // Set the value at address...
        *serviceArrayPointer = get_service_array();
        return 0;
    }
    else return 1;
}

MYService *get_index_value(MYService **service_array, int index)
{
    return service_array[index];
}

int get_count(MYService **service_array)
{
    int index = 0;
    while(service_array[index] != NULL)
    {
        index++;
    }
    return index;
}

int
main(int argc, char **argv)
{
    // Call all the methods for testing purposes.
    // This method is not wrapped using SWIG.
    // MYService *service = NULL;
    //service = get_service();
    //printf("get_service output:%s\n", service->stringEntry);
    //free(service);
    //printf("--------------------------------------------------------------\n");
    //service = NULL;
    // MYService **serviceArray = get_service_array();

    // int index =0;
    //service = get_next(serviceArray, 5);
    //for (service = get_next(serviceArray, index++);
    // service != NULL;
    // service = get_next(serviceArray, index++))
    //{
    //    printf("    entry:%s\n", service->stringEntry);
    //    free(service);
    //}
    //int index = 0;
    //printf("get_service_array output:\n");
    //while(serviceArray[index] != NULL)
    //{
    //    service = serviceArray[index++];;
    //    printf("    entry:%s\n", service->stringEntry);
    //    free(service);
    //}
    // free(serviceArray);
    // printf("--------------------------------------------------------------\n");
    //service = NULL;
    //fillup_service(0, &service);
    //printf("fillup_service output:%s\n", service->stringEntry);
    //free(service);
    //printf("--------------------------------------------------------------\n");
    //service = NULL;
    //printf("fillup_service_array output:\n");
    //serviceArray = NULL;
    //fillup_service_array(0, &serviceArray);
    //index = 0;
    //while(serviceArray[index] != NULL)
    //{
    //    service = serviceArray[index++];;
    //    fprintf(stderr, "    entry:%s\n", service->stringEntry);
    //    free(service);
    //}
    //free(serviceArray);
    return 0;
}
