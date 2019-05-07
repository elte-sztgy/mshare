import { Component, OnInit, Input, OnChanges, ChangeDetectionStrategy } from '@angular/core';
import { GroupInfo, GroupData, MemberData } from '../group-manager/group-manager.component';
import { Spending } from '../spending-creator/spending-creator.component'
import { Output, EventEmitter } from '@angular/core'; 

@Component({
  selector: 'app-group-detail',
  templateUrl: './group-detail.component.html',
  styleUrls: ['./group-detail.component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class GroupDetailComponent implements OnChanges {
  @Input() groupData: GroupData;
  @Input() spendings: Spending[];
  calculatedSpendings: CalculatedSpending[]=[];
  pages={groupMemberDetails:0,groupSpendingDetails:1};
  selectedPage=this.pages.groupMemberDetails;
  @Output() startSpendingCreation = new EventEmitter();

  ngOnChanges(){
    this.showPage(this.selectedPage);
  }

  startCreateSpending() {
    this.startSpendingCreation.emit(new GroupInfo(this.groupData));
  }

  constructor() { }

  calcGroupSpending(){
    if(this.calculatedSpendings!=undefined){
      delete this.calculatedSpendings;
      this.calculatedSpendings=[];
    }
    for(let spending of this.spendings){
      var calculatedSpending=new CalculatedSpending();
      calculatedSpending.spending=spending;
      if(spending.debtors.length==this.groupData.memberCount){
        calculatedSpending.groupSpending=true;
      }
      else{
        calculatedSpending.groupSpending=false;
      }
      this.calculatedSpendings=[...this.calculatedSpendings,calculatedSpending];
    }
  }

  ngOnInit() {

  }

  showPage(selectedPage){
    this.selectedPage=selectedPage;
    if(this.selectedPage==this.pages.groupSpendingDetails){
      this.calcGroupSpending();
    }
  }
}

export class CalculatedSpending{
  spending: Spending;
  groupSpending:boolean;
}