// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract JobPortal {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }
    struct Applicant {
        uint256 id;
        string Name;
        uint8 age;
        uint256 rating;
        uint256[] applied_jobs;
        uint256[] applications;
    }

    struct Job {
        string Name;
        uint256 id;
        string desc;
    }
    struct Application {
        uint256 id;
        uint256 applicant_id;
        uint256 job_id;
        string application_type;
    }

    //mapping(key=>value) mapping_name
    mapping(uint8 => Application) applications;
    mapping(uint8 => Applicant) applicants;
    mapping(uint8 => Job) jobs;

    function getJob(uint8 _id) public view returns (Job memory) {
        return jobs[_id];
    }

    function getApplication(uint8 _id)
        public
        view
        returns (Application memory)
    {
        return applications[_id];
    }

    function getApplicant(uint8 _id) public view returns (Applicant memory) {
        return applicants[_id];
    }

    function setJob(
        uint8 _id,
        string memory name,
        string memory desc
    ) public {
        jobs[_id].id = _id;
        jobs[_id].Name = name;
        jobs[_id].desc = desc;
    }

    function setApplicant(
        uint8 _id,
        string memory name,
        uint8 age,
        uint256 rating
    ) public onlyAdmin{
        applicants[_id].id = _id;
        applicants[_id].Name = name;
        applicants[_id].age = age;
        applicants[_id].rating = rating;
    }

    function setApplication(
        uint8 _id,
        uint8 applicant_id,
        uint8 job_id,
        string memory application_type
    ) public {
        applications[_id].id = _id;
        applications[_id].applicant_id = applicant_id;
        applications[_id].job_id = job_id;
        applications[_id].application_type = application_type;
        applicants[applicant_id].applied_jobs.push(job_id);
        applicants[applicant_id].applications.push(_id);
    }

    function setRating(uint8 applicant_id, uint256 rating) public {
        applicants[applicant_id].rating = rating;
    }
}
