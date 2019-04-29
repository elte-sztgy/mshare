package elte.moneyshare.model


import elte.moneyshare.entity.*
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.http.*

interface APIDefinition {

    //AUTH
    @PUT("/api/Auth/login")
    fun putLoginUser(@Body loginCred: LoginCred): Call<LoginResponse>

    @POST("/api//Auth/register")
    fun postRegisterUser(@Body registrationData: RegistrationData): Call<Any>


    //GROUP
    @GET("/api/Group/{id}")
    fun getGroup(@Path("id") groupId: Int): Call<Group>

    @GET("/api/Group/{groupId}/info")
    fun getGroupInfo(@Path("groupId") groupId: Int): Call<GroupInfo>

    @GET("/api/Group/{groupId}/data")
    fun getGroupData(@Path("groupId") groupId: Int): Call<GroupData>

    @POST("/api/Group/create")
    fun postNewGroup(@Body groupName : NewGroup) : Call<ResponseBody>


    //PROFILE
    @GET("/api/Profile/groups")
    fun getProfileGroups(): Call<ArrayList<GroupInfo>>


    //SPENDING
    @GET("api/Spending/{id}")
    fun getSpendings(@Path("id") groupId: Int): Call<ArrayList<SpendingData>>

    //TEST METHOD
    @GET("/api/Group/")
    fun getGroups(): Call<ArrayList<Group>>

    @GET("/api/Auth")
    fun getUsers(): Call<ArrayList<User>>
}