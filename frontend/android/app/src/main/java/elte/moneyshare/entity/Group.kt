package elte.moneyshare.entity

data class Group(
    var id: Int,
    var name: String,
    var creatorUser: Member,
    var members: ArrayList<Member>,
    var memberCount: Int,
    var balance: Int
)